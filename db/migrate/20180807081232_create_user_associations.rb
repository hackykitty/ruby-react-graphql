class CreateUserAssociations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_associations do |t|
      t.belongs_to :following_user, null: false
      t.belongs_to :followed_by_user, null: false
      t.timestamps null: false
    end

    add_foreign_key :user_associations, :users, column: :following_user_id
    add_foreign_key :user_associations, :users, column: :followed_by_user_id
  end
end
