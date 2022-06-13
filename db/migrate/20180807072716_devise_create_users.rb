# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :username, null: false, index: :unique
      t.string :email, null: false, index: :unique
      t.string :encrypted_password, null: false
      t.timestamps null: false
    end
  end
end
