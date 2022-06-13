require 'rails_helper'

describe Post do
  describe '.reverse_chronological' do
    it 'returns the posts in reverse chronological order' do
      post_1 = create :post, created_at: 2.days.ago
      post_2 = create :post, created_at: 1.day.ago

      expect(described_class.reverse_chronological).to eq [post_2, post_1]
    end
  end
end
