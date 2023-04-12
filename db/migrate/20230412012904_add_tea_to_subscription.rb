# frozen_string_literal: true

class AddTeaToSubscription < ActiveRecord::Migration[6.1]
  def change
    add_reference :subscriptions, :tea, null: false, foreign_key: true
  end
end
