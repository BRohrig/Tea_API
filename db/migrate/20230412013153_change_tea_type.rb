# frozen_string_literal: true

class ChangeTeaType < ActiveRecord::Migration[6.1]
  def change
    rename_column :teas, :type, :variety
  end
end
