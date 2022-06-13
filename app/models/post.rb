# == Schema Information
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  comments_count :integer          default(0), not null
#  description    :string           not null
#  tagline        :string           not null
#  title          :string           not null
#  url            :string           not null
#  votes_count    :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user, required: true, inverse_of: :posts

  has_many :comments, dependent: :destroy, inverse_of: :post
  has_many :commenters, through: :comments, source: :user
  has_many :votes, dependent: :destroy, inverse_of: :post
  has_many :voters, through: :votes, source: :user

  validates :title, :tagline, presence: true
  validates :url, url: true, presence: true

  scope :reverse_chronological, -> { order(arel_table[:created_at].desc) }
end
