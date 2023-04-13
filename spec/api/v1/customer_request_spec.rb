# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'customer endpoints' do
  before(:all) do
    Customer.delete_all
  end

  it 'has an endpoint to create a new customer' do
    new_customer_input = {  first_name: 'Bob',
                            last_name: 'Also Bob',
                            email: 'BobbityBob@bob.com',
                            address: '1234 Bob Lane',
                            city: 'Bobtown',
                            zip_code: 98_203,
                            password: 'Bobisbadatpasswords' }

    post api_v1_customers_path, params: new_customer_input

    expect(response).to be_successful

    customer_data = JSON.parse(response.body, symbolize_names: true)[:data]

    new_customer = Customer.last
    expect(new_customer.first_name).to eq('Bob')
    expect(new_customer.email).to eq('BobbityBob@bob.com')
    expect(new_customer.city).to eq('Bobtown')

    expect(customer_data).to eq({ id: new_customer.id.to_s,
                                  type: 'customer',
                                  attributes: { first_name: 'Bob',
                                                last_name: 'Also Bob',
                                                email: 'BobbityBob@bob.com',
                                                address: '1234 Bob Lane',
                                                city: 'Bobtown',
                                                zip_code: 98_203 } })
  end

  it 'has an endpoint to allow a customer to modify their information' do
    customer = create(:customer)

    update_params = { first_name: 'A name',
                      last_name: 'another name',
                      email: 'thisisanemail@email.com4',
                      address: 'fake address',
                      city: 'FakeCity',
                      zip_code: 0o00001,
                      password: 'password' }

    expect(customer.first_name).to_not eq('A name')
    expect(customer.last_name).to_not eq('another name')
    expect(customer.email).to_not eq('thisisanemail@email.com4')
    expect(customer.address).to_not eq('fake address')
    expect(customer.city).to_not eq('FakeCity')
    expect(customer.zip_code).to_not eq(0o00001)

    patch api_v1_customer_path(customer.id), params: update_params

    expect(response).to be_successful

    customer_response = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(customer_response).to eq([{ id: customer.id.to_s,
                                       type: 'customer',
                                       attributes: { first_name: 'A name',
                                                     last_name: 'another name',
                                                     email: 'thisisanemail@email.com4',
                                                     address: 'fake address',
                                                     city: 'FakeCity',
                                                     zip_code: 0o00001 } }])

    updated_customer = Customer.find(customer.id)

    expect(updated_customer.first_name).to eq('A name')
    expect(updated_customer.last_name).to eq('another name')
    expect(updated_customer.email).to eq('thisisanemail@email.com4')
    expect(updated_customer.address).to eq('fake address')
    expect(updated_customer.city).to eq('FakeCity')
    expect(updated_customer.zip_code).to eq(0o00001)
  end

  it 'has an endpoint to delete a customer' do
    customer = create(:customer)

    delete api_v1_customer_path(customer.id)

    expect(response).to be_successful

    expect(response.body).to eq('Customer Deleted Successfully')
    expect { Customer.find(customer.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
