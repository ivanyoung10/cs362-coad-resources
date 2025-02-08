FactoryBot.define do
  factory :resource_category do
    sequence(:name) { |n| "category#{n}" }

    trait :unspecified do
      name { 'Unspecified' }
    end
  end
end