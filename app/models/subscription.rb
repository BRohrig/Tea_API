# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates_presence_of :price
  validates_presence_of :status
  validates_presence_of :frequency

  def self.status_filter(status)
    if status.nil?
      all
    else
      where(status: status)
    end
  end
end
