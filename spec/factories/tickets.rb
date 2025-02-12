#Ivan
 FactoryBot.define do
  factory :ticket do
    sequence(:name)  {|n| "ticket#{n}"}
    sequence(:region_id)  {|n| "region#{n}"}
    sequence(:organization_id)  {|n| "organization#{n}"}

    phone { '+1-111-111-1111' }
  end

 end