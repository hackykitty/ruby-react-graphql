# == Schema Information
#
# Table name: user_associations
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  followed_by_user_id :bigint           not null
#  following_user_id   :bigint           not null
#
# Indexes
#
#  index_user_associations_on_followed_by_user_id  (followed_by_user_id)
#  index_user_associations_on_following_user_id    (following_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (followed_by_user_id => users.id)
#  fk_rails_...  (following_user_id => users.id)
#
class UserAssociation < ApplicationRecord
  belongs_to :followed_by_user, class_name: 'User', required: true
  belongs_to :following_user, class_name: 'User', required: true
end
