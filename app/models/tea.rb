# frozen_string_literal: true

class Tea < ApplicationRecord
  has_many :subscriptions

  validates_presence_of :name, :variety, :brew_time
end
