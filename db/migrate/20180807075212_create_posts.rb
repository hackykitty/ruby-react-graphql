class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :tagline, null: false
      t.string :description, null: false
      t.string :url, null: false
      t.integer :comments_count, null: false, default: 0

      t.belongs_to :user, null: false
      t.timestamps null: false
    end

    add_foreign_key :posts, :users
  end
end
