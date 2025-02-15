#Ivan
FactoryBot.define do
  factory :ticket do
    sequence(:name)  {|n| "ticket#{n}"}
    sequence(:region_id)  {|n| "region#{n}"}
    sequence(:resource_category_id)  {|n| "resource_category#{n}"}

    phone { "+1-555-555-1212" }
  end

end