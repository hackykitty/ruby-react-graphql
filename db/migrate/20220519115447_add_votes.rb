class AddVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: false
      t.belongs_to :post, null: false, foreign_key: true, index: true
      t.timestamps null: false
    end

    add_index :votes, %i(user_id post_id), unique: true

    add_column :posts, :votes_count, :integer, null: false, default: 0
    add_column :users, :votes_count, :integer, null: false, default: 0
  end
end
