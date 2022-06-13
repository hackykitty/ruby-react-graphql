module Types
  class BaseObject < GraphQL::Schema::Object
    class << self
      def association(name, type, null:, preload: nil)
        resolver = Resolvers::AssociationResolver.build(
          preload: preload || name,
          type: type,
          null: null,
        )

        field name, resolver: resolver
      end
    end
  end
end
