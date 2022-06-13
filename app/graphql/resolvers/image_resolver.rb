class Resolvers::ImageResolver < GraphQL::Schema::Resolver
  argument :width, Int, required: false
  argument :height, Int, required: false

  type String, null: false

  def resolve(width: 200, height: 200)
    "https://via.placeholder.com/#{width}x#{height}"
  end
end
