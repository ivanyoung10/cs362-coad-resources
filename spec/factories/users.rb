#Ivan
FactoryBot.define do 
  factory :user do 
    sequence(:email) { |n| "valid#{n}@example.com" }
    password { "fake_password"}

    before(:create) { |user| user.skip_confirmation!}

    trait :organization_approved do 
      role {:organization}
      organization_id { create(:organization, :approved).id}
    end

    trait :organization_unapproved do 
      role {:organization}
      organization_id { create(:organization).id}
    end

    trait :admin do 
      role { :admin }
    end
  end
end