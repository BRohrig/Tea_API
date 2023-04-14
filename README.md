# README

## About

* This application is an API designed to expose endpoints for customers to create an account, and create subscriptions for purchasing Tea on varying intervals. This application as setup also includes Continuous Integration using Github Actions.

## Technical Specifications

* Ruby version 3.0.6, and Rails version 6.1.7.3.

* The gems and associated dependencies can be found in the Gemfile, any that are not installed locally can be done so with `gem install '<gem name>'`

## Setup

* After cloning this repo locally, run `bundle install`

* Then create the PostgreSQL database with `rails db:{create,migrate,seed}`

### Schema
<div align="center">
  <img src="https://github.com/BRohrig/Tea_API/blob/main/Screen%20Shot%202023-04-13%20at%208.59.10%20AM.png"
  alt="Profile" width="1280">
</div>

## Testing

* To run the test suite following setup, run `bundle exec rspec`

## Endpoints

All endpoints return a JSON object.

### Customer Creation

POST /api/v1/customers

Request Body is a JSON object in the following format:
```
{
"first_name": <string>,
"last_name": <string>,
"email": <string>,
"address": <string>,
"city": <string>,
"zip_code": <integer>,
"password": <string>
}
```
Response:
```
{
    "data": {
        "id": "1",
        "type": "customer",
        "attributes": {
            "first_name": <string>,
            "last_name": <string>,
            "address": <string>,
            "city": <string>,
            "email": <string>,
            "zip_code": <integer>
        }
    }
}
```
Please note that Password is encrypted server side and not returned in the response.

Also note that if an email has already been used, the following response will be received:
```
{
    "error": {
        "email": [
            "has already been taken"
        ]
    }
}
```
### Customer Deletion

DELETE /api/v1/customers/:customer_id

Request has no body or parameters other than customer_id

Response: 
```
Customer Deleted Successfully
```
### Customer Updating

PATCH /api/v1/customers/:customer_id

Request Body is a JSON object which includes any combination of the following Key/value pairs
```
{
"first_name": <string>,
"last_name": <string>,
"email": <string>,
"address": <string>,
"city": <string>,
"zip_code": <integer>,
"password": <string>
}
```
Response:
```
{
    "data": {
        "id": "1",
        "type": "customer",
        "attributes": {
            "first_name": <string>,
            "last_name": <string>,
            "address": <string>,
            "city": <string>,
            "email": <string>,
            "zip_code": <integer>
        }
    }
}
```
### Invalid Customer

If a patch or delete request is sent to an invalid customer ID, the response will be status 404, and the response body will be:
```
{
  "error": "Couldn't find Customer with 'id'=<request_id>"
}
```
### Subscription Creation

POST /api/v1/customers/:customer_id/subscriptions

Request Body is a JSON object in the following format:
```
{
    "nickname": <string>, <OPTIONAL>
    "price": <float>,
    "status": <string>, 
    "frequency": <string>,
    "tea_id": <valid_tea_id>
}
```
Response:
```
{
    "data": {
        "id": <id>,
        "type": "subscription",
        "attributes": {
            "nickname": <nickname_input OR null>,
            "price": <input_price_>,
            "status": <input_status>,
            "frequency": <input_frequency>
        }
    }
}
```
NOTE:

If an invalid <tea_id> is sent, the response body will be as follows:
```
{
    "error": {
        "tea": [
            "must exist"
        ]
    }
}
```
### Subscription Updating

PATCH /api/v1/customers/:customer_id/subscriptions/:subscription_id

Request Body accepts only the following two parameters:
```
{
  "nickname": <new_nickname>,
  "status": <new_status>
}
```
Response:
```
{
    "data": {
        "id": <id>,
        "type": "subscription",
        "attributes": {
            "nickname": <new_nickname>,
            "price": <price_>,
            "status": <new_status>,
            "frequency": <frequency>
        }
    }
}
```
### Subscription Index

GET /api/v1/customers/:customer_id/subscriptions

NOTE: This endpoint accepts an optional query parameter of `?status=<status>` which allows the user to only get subscriptions which match the status requested.

Response:
```
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "nickname": <nickname OR null>,
                "price": <price>,
                "status": <status OR match query param>,
                "frequency": <frequency>
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "nickname": <nickname OR null>,
                "price": <price>,
                "status": <status OR match query param>,
                "frequency": <frequency>
            }
        }....
    ]
}