# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { should belong_to(:customer) }
  it { should belong_to(:tea) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:frequency) }

  it 'has a class method to find instances of itself with a matching status' do
    customer = create(:customer)
    customer2 = create(:customer)
    tea = create(:tea)
    create_list(:subscription, 6, customer_id: customer.id, tea_id: tea.id, status: 'Active')
    create_list(:subscription, 4, customer_id: customer.id, tea_id: tea.id, status: 'Inactive')

    expect(customer.subscriptions.status_filter('Active').count).to eq(6)
    expect(customer.subscriptions.status_filter('Inactive').count).to eq(4)
    expect(customer2.subscriptions.status_filter('Active').count).to eq(0)
    expect(customer2.subscriptions.status_filter('Inactive').count).to eq(0)
    expect(customer.subscriptions.status_filter(nil).count).to eq(10)
  end
end
