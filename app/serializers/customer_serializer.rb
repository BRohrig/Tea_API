class CustomerSerializer
  include JSONAPI::Serializer
  attributes  :first_name, 
              :last_name, 
              :address, 
              :city,
              :email, 
              :zip_code


end