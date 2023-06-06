FactoryBot.define do
  factory :guest_phone_number do
    phone { "1234567890" }
    guest
  end
end
