class KittynewsSchema < GraphQL::Schema
  mutation Types::MutationType
  query Types::QueryType
  context_class Utils::Context
  use GraphQL::Batch
end
