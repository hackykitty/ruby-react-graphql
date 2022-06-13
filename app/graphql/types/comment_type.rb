module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :text, String, null: false
    field :created_at, String, null: false

    association :user, UserType, null: false
  end
end
