class Subscription < ApplicationRecord
  belongs_to :customer

  validates_presence_of :price
  validates_presence_of :status
  validates_presence_of :frequency

  def self.status_filter(status)
    if status == nil
      self.all
    else 
      self.where(status: status)
    end
  end
end