FactoryBot.define do
  factory :reservation do
    association :guest
    reservation_code { "XYZ12345678" }
    start_date { "2022-05-01" }
    end_date { "2022-05-05" }
    nights { 4 }
    guests { 4 }
    adults { 2 }
    children { 2 }
    infants { 0 }
    status { "accepted" }
    total_price { "4000.00" }
    currency { "AUD" }
  end
end
