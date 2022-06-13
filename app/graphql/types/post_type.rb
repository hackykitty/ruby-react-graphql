module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :tagline, String, null: false
    field :url, String, null: false
    field :comments_count, Int, null: false
    field :votes_count, Int, null: false
    field :created_at, String, null: false
    field :is_voted, resolver: Resolvers::IsVotedResolver
    field :can_be_voted, Boolean, null: false
    field :description, String, null: false
    field :views_count, Int, null: false
    field :daily_feed_position, Int, null: false
    field :weekly_feed_position, Int, null: false

    field :image, resolver: Resolvers::ImageResolver

    field :makers, [UserType], null: false

    association :user, UserType, null: false
    association :comments, [CommentType], null: false
    association :commenters, [UserType], null: false
    association :voters, [UserType], null: false

    def can_be_voted
      context.current_user.present?
    end

    def makers
      []
    end

    def view_count
      155
    end

    def daily_feed_position
      1
    end

    def weekly_feed_position
      3
    end

    def views_count
      1000
    end
  end
end
