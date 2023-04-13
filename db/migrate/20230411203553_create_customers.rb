# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :city
      t.integer :zip_code
      t.string :password_digest

      t.timestamps
    end
  end
end
