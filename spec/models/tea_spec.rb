require 'rails_helper'

RSpec.describe Tea type: :model do
  it { should have_many(:subscriptions) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:brew_time) }
end