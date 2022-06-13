class Resolvers::IsVotedResolver < GraphQL::Schema::Resolver
  type Boolean, null: false

  def resolve
    return false if context.current_user.blank?

    VotesLoader.for(context.current_user).load(object.id)
  end

  class VotesLoader < GraphQL::Batch::Loader
    def initialize(user)
      @user = user
    end

    def perform(post_ids)
      voted_post_ids = @user.votes.where(post_id: post_ids).pluck(:post_id)

      post_ids.each do |post_id|
        fulfill post_id, voted_post_ids.include?(post_id)
      end
    end
  end
end
