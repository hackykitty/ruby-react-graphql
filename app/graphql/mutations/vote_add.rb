module Mutations
  class VoteAdd < Mutations::BaseMutation
    null true

    argument :post_id, ID, required: true

    field :post, Types::PostType, null: false
    field :errors, [String], null: false

    def resolve(post_id:)
      require_current_user!

      post = Post.find(post_id)

      Vote.find_or_create_by!(user: context.current_user, post: post)

      {
        post: post,
        errors: [],
      }
    rescue ActiveRecord::RecordNotFound
      return_record_not_found
    end
  end
end
