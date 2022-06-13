require 'rails_helper'

describe Mutations::VoteAdd do
  let(:post) { create :post }
  let(:user) { create :user, name: 'name' }

  def call(current_user:, context: {}, **args)
    context = Utils::Context.new(
      query: OpenStruct.new(schema: KittynewsSchema),
      values: context.merge(current_user: current_user),
      object: nil,
    )
    described_class.new(object: nil, context: context, field: nil).resolve(args)
  end

  it 'adds a vote' do
    result = call(current_user: user, post_id: post.id)

    expect(result).to eq post: post, errors: []
    expect(result[:post].votes_count).to eq 1
    expect(Vote.where(user: user, post: post).exists?).to eq true
  end

  it 'can be called twice' do
    call(current_user: user, post_id: post.id)

    result = call(current_user: user, post_id: post.id)

    expect(result).to eq post: post, errors: []
    expect(result[:post].votes_count).to eq 1
  end

  it 'requires existing post' do
    result = call(current_user: user, post_id: '-1')

    expect(result).to eq errors: ["Record not found"]
  end

  it 'requires a logged in user' do
    expect { call(current_user: nil, post_id: post.id) }.to raise_error GraphQL::ExecutionError, 'current user is missing'
  end
end
