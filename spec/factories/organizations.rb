FactoryBot.define do
  factory :organization do
    sequence(:name) { |n| "organization#{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    phone { "+1-111-111-1111" }
    primary_name { "Name Nameson" }
    secondary_name { "Name Nameson Jr. The Fifth" }
    secondary_phone { "+2-222-222-2222" }
    status { "submitted" }
  end
end