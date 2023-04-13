class ChangePriceToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :subscriptions, :price, :float
  end
end
