# frozen_string_literal: true

class AddPriceToTea < ActiveRecord::Migration[6.1]
  def change
    add_column :teas, :price, :float
  end
end
