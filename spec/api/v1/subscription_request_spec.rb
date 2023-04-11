require 'rails_helper'

RSpec.describe 'subscription endpoints' do
  before(:all) do
    @customer = create(:customer)
  end

  it 'has an endpoint to create a subscription for a given customer' do
    subscription_data = { nickname: "I love this tea!",
                          price: 20,
                          status: "Active",
                          frequency: "Monthly"}

    post api_v1_customer_subscriptions_path(@customer.id), params: subscription_data

    expect(response).to be_successful

    subscription = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(subscription[:nickname]).to eq("I love this tea!")
    expect(subscription[:price]).to eq(20)
    expect(subscription[:status]).to eq("Active")
    expect(subscription[:frequency]).to eq("Monthly")
    new_subscription = @customer.subscriptions.last

    expect(new_subscription.nickname).to eq("I love this tea!")
    expect(new_subscription.price).to eq(20)
    expect(new_subscription.status).to eq("Active")
    expect(new_subscription.frequency).to eq("Monthly")
  end
end