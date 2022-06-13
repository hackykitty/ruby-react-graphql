module Mutations
  class VoteRemove < Mutations::BaseMutation
    null true

    argument :post_id, ID, required: true

    field :post, Types::PostType, null: false
    field :errors, [String], null: false

    def resolve(post_id:)
      require_current_user!

      post = Post.find(post_id)
      post.votes.find_by(user: context.current_user)&.destroy!

      {
        post: post,
        errors: [],
      }
    rescue ActiveRecord::RecordNotFound
      return_record_not_found
    end
  end
end
