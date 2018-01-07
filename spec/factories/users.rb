FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(8) }

    factory :user_confirmed do
      confirmed_at { Time.now }
    end
    factory :admin do
      confirmed_at { Time.now }
      is_admin true
    end
  end
end
