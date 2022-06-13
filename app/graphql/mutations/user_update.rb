module Mutations
  class UserUpdate < Mutations::BaseMutation
    null true

    argument :name, String, required: false

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(name:)
      require_current_user!

      user = context[:current_user]

      if user.update name: name
        {
          user: user,
          errors: [],
        }
      else
        {
          user: nil,
          errors: user.errors.full_messages
        }
      end
    end
  end
end
