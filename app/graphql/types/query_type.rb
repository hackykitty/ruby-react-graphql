module Types
  class QueryType < Types::BaseObject
    field :posts_all, [PostType], null: false

    field :post, PostType, null: true do
      argument :id, ID, required: true
    end

    field :viewer, ViewerType, null: true

    def posts_all
      Post.reverse_chronological.all
    end

    def post(id:)
      Post.find_by id: id
    end

    def viewer
      context.current_user
    end
  end
end
