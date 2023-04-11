class Api::V1::SubscriptionsController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions.create(subscription_params))
  end

  private

  def subscription_params
    params.permit(:nickname,
                  :price, 
                  :status,
                  :frequency)
  end

end