# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      def create
        new_customer = Customer.create(customer_data)
        render json: CustomerSerializer.new(new_customer)
      end

      def update
        updated_customer = Customer.update(customer_data)
        render json: CustomerSerializer.new(updated_customer)
      end

      def destroy
        Customer.find(params[:id]).delete
        render json: 'Customer Deleted Successfully'
      end

      private

      def customer_data
        params.permit(:first_name,
                      :last_name,
                      :address,
                      :email,
                      :city,
                      :zip_code,
                      :password)
      end
    end
  end
end
