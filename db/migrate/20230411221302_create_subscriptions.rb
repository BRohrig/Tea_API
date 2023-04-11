class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :nickname
      t.integer :price
      t.string :status
      t.string :frequency
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
