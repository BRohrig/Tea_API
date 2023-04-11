class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes  :nickname,
              :price,
              :status,
              :frequency

end