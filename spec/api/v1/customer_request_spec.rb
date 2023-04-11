require 'rails_helper'

RSpec.describe 'customer endpoints' do
  it 'has an endpoint to create a new customer' do
    new_customer_input = {  first_name: "Bob",
                            last_name: "Also Bob",
                            email: "BobbityBob@bob.com",
                            address: "1234 Bob Lane",
                            city: "Bobtown",
                            zip_code: 98203,
                            password: "Bobisbadatpasswords" }

    post api_v1_customers_path, params: new_customer_input

    expect(response).to be_successful

    customer_data = JSON.parse(response.body, symbolize_names: true)[:data]

    new_customer = Customer.last
    expect(new_customer.first_name).to eq("Bob")
    expect(new_customer.email).to eq("BobbityBob@bob.com")
    expect(new_customer.city).to eq("Bobtown")

    expect(customer_data).to eq({ id: "#{new_customer.id}",
                                  type: "customer",
                                  attributes: { first_name: "Bob",
                                                last_name: "Also Bob",
                                                email: "BobbityBob@bob.com",
                                                address: "1234 Bob Lane",
                                                city: "Bobtown",
                                                zip_code: 98203 }})

   
  end

end