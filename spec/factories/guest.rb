FactoryBot.define do
  factory :guest do
    first_name { "John" }
    last_name  { "Doe" }
    email { "john_doe@example.com" }

    after(:create) do |guest|
      create_list(:guest_phone_number, 1, guest: guest)
    end
  end
end
