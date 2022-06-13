module Utils
  class Context < GraphQL::Query::Context
    def current_user
      self[:current_user]
    end

    def current_user=(current_user)
      self[:current_user] = current_user
    end

    def request
      self[:request]
    end
  end
end
