class Api::V1::SubscriptionsController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions.create(subscription_params))
  end

  def index
    render json: SubscriptionSerializer.new(Customer.find(params[:customer_id]).subscriptions)
  end

  def update
    Subscription.find(params[:id]).update(update_params)
    subscription = Subscription.find(params[:id])
    render json: SubscriptionSerializer.new(subscription)
  end

  private

  def subscription_params
    params.permit(:nickname,
                  :price, 
                  :status,
                  :frequency)
  end

  def update_params
    params.permit(:nickname, :status)
  end
end