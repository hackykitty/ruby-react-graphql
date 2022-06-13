# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string           not null
#  encrypted_password :string           not null
#  name               :string           not null
#  username           :string           not null
#  votes_count        :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email)
#  index_users_on_username  (username)
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  has_many :user_associations, class_name: 'UserAssociation', foreign_key: :followed_by_user_id, dependent: :destroy
  has_many :followees, through: :user_associations, source: :following_user

  has_many :posts, dependent: :destroy, inverse_of: :user
  has_many :comments, dependent: :destroy, inverse_of: :user
  has_many :votes, dependent: :destroy, inverse_of: :user

  validates :name, presence: true
end
