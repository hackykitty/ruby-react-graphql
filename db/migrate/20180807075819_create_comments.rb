class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :text, null: false

      t.belongs_to :user, null: false
      t.belongs_to :post, null: false

      t.timestamps null: false
    end

    add_foreign_key :comments, :users
    add_foreign_key :comments, :posts
  end
end
