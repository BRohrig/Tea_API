class Customer < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of  :first_name,
                         :last_name, 
                         :address, 
                         :city, 
                         :zip_code, 
                         :password

  has_secure_password

end