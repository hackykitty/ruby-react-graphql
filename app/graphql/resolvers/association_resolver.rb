# frozen_string_literal: true

# Note(rstankov):
#
#  **Don't use for `connection`s, only for `field` attributes**
#
# Preload associations.
#
# Supports all preload formats from [ActiveRecord::Base.includes](https://api.rubyonrails.org/v5.2.4/classes/ActiveRecord/QueryMethods.html#method-i-includes).
#
#  Default handler returns
#
#  - preload(:assoc) => model.assoc
#  - preload([:assoc1, assoc2]) => model.assoc1
#  - preload(assoc1: :nested1, assoc2: :nested2) => model.assoc1
#

module Resolvers::AssociationResolver
  extend self

  def build(preload:, type:, null:, handler: nil)
    resolver_class = Class.new(Resolver)
    resolver_class.type type, null: null
    resolver_class.define_method(:preload) { preload }
    resolver_class.define_method(:handler) { handler } if handler.present?
    resolver_class
  end

  class Resolver < GraphQL::Schema::Resolver
    def resolve
      return if object.blank?

      AssociationLoader.for(preload).load(object).then do |loaded_association|
        if handler.arity == 2
          handler.call loaded_association, object
        else
          handler.call loaded_association
        end
      end
    end

    def preload
      raise NotImplementedError
    end

    def handler
      DefaultHandler
    end
  end

  module DefaultHandler
    extend self

    def arity
      1
    end

    def call(loaded_association)
      loaded_association
    end
  end

  class AssociationLoader < GraphQL::Batch::Loader
    def initialize(preload)
      @preload = preload
    end

    def load(record)
      return Promise.resolve(read_association(record, preload)) if association_loaded?(record, preload)

      super
    end

    # NOTE(rstankov): We want to load the associations on all records, even if they have the same id
    def cache_key(record)
      record.object_id
    end

    def perform(records)
      ::ActiveRecord::Associations::Preloader.new(records: records, associations: preload).call

      records.each do |record|
        fulfill(record, read_association(record, preload))
      end
    end

    private

    attr_reader :preload

    def read_association(record, association_name)
      case association_name
      when Array then read_association(record, association_name.first)
      when Hash then read_association(record, association_name.keys.first)
      else record.public_send(association_name)
      end
    end

    def association_loaded?(record, association_name)
      case association_name
      when Array then association_name.all? { |name| association_loaded?(record, name) }
      when Hash
        association_name.all? do |(name, nested_associations)|
          association_loaded?(record, name) && association_loaded?(read_association(record, name), nested_associations)
        end
      else record.association(association_name).loaded?
      end
    end
  end
end
