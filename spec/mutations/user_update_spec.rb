require 'rails_helper'

describe Mutations::UserUpdate do
  let(:object) { :not_used }
  let(:user) { create :user, name: 'name' }

  def call(current_user:, context: {}, **args)
    context = Utils::Context.new(
      query: OpenStruct.new(schema: KittynewsSchema),
      values: context.merge(current_user: current_user),
      object: nil,
    )
    described_class.new(object: nil, context: context, field: nil).resolve(args)
  end

  it 'updates the current user' do
    result = call(current_user: user, name: 'New name')

    expect(result).to eq user: user, errors: []
    expect(user.name).to eq 'New name'
  end

  it 'requires user name' do
    result = call(current_user: user, name: '')

    expect(result).to eq user: nil, errors: ["Name can't be blank"]
  end

  it 'requires a logged in user' do
    expect { call(current_user: nil, name: 'Name') }.to raise_error GraphQL::ExecutionError, 'current user is missing'
  end
end
