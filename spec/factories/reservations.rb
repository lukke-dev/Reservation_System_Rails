FactoryBot.define do
  factory :reservations do
    user_id { 1 }
    book_id { 1 }
    booking_date { "2022-09-21 00:43:25" }
    return_date { "2022-09-21 00:43:25" }
    booking_status { 1 }
  end
end
