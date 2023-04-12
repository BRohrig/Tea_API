# frozen_string_literal: true

class CreateTea < ActiveRecord::Migration[6.1]
  def change
    create_table :teas do |t|
      t.string :name
      t.string :type
      t.float :brew_time

      t.timestamps
    end
  end
end
