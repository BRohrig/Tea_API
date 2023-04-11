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

  it 'has an endpoint to display all of the subscriptions for a user' do
    create_list(:subscription, 5, customer_id: @customer.id)

    get api_v1_customer_subscriptions_path(@customer.id)

    expect(response).to be_successful

    subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(subscriptions.count).to eq(5)
    subscriptions.each do |subscription|
      expect(subscription[:attributes]).to have_key(:nickname)
      expect(subscription[:attributes]).to have_key(:price)
      expect(subscription[:attributes]).to have_key(:status)
      expect(subscription[:attributes]).to have_key(:frequency)
    end
  end
end