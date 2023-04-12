require 'rails_helper'

RSpec.describe 'subscription endpoints' do
  before(:all) do
    @customer = create(:customer)
    @tea = create(:tea)
  end

  describe 'subscription creation endpoint' do
    it 'has an endpoint to create a subscription for a given customer' do
      subscription_data = { nickname: "I love this tea!",
                            price: 20,
                            status: "Active",
                            frequency: "Monthly",
                            tea_id: @tea.id }

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

    it 'returns the appropriate 422 error when a subscription cannot be created' do
      subscription_data = { nickname: "this is a tea",
                            price: "1" }

      post api_v1_customer_subscriptions_path(@customer.id), params: subscription_data
      
      expect(response).to_not be_successful

      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to eq({ :error=>{:frequency=>["can't be blank"], :status=>["can't be blank"], :tea=>["must exist"]}})

    end
  end

  describe 'subscription index endpoint' do
    it 'has an endpoint to display all of the subscriptions for a user' do
      create_list(:subscription, 5, customer_id: @customer.id, tea_id: @tea.id)

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

    it 'accepts a parameter to filter by status' do
      create_list(:subscription, 3, customer_id: @customer.id, tea_id: @tea.id, status: "Active")
      create_list(:subscription, 5, customer_id: @customer.id, tea_id: @tea.id, status: "Inactive")

      get api_v1_customer_subscriptions_path(@customer.id), params: { status: "Active" }

      expect(response).to be_successful

      active_subs = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(active_subs.count).to eq(3)
      active_subs.each do |sub|
        expect(sub[:attributes][:status]).to eq("Active")
      end

      get api_v1_customer_subscriptions_path(@customer.id), params: { status: "Inactive" }

      expect(response).to be_successful

      inactive_subs = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(inactive_subs.count).to eq(5)
      inactive_subs.each do |sub|
        expect(sub[:attributes][:status]).to eq("Inactive")
      end
    end
  end

  describe 'subscription update endpoint' do
    it 'has an endpoint to update the status and nickname of a subscription' do
      subscription = create(:subscription, customer_id: @customer.id, tea_id: @tea.id, status: "Active")

      patch api_v1_customer_subscription_path(@customer.id, subscription.id), params: { nickname: "I hate this tea", status: "Inactive" }

      expect(response).to be_successful

      updated_sub = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(updated_sub[:attributes][:nickname]).to eq("I hate this tea")
      expect(updated_sub[:attributes][:status]).to eq("Inactive")
      expect(updated_sub[:attributes][:price]).to eq(subscription.price)
      expect(updated_sub[:attributes][:frequency]).to eq(subscription.frequency)
    end
  end
end