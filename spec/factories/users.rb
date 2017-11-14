FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(8) }

    factory :user_confirmed do
      confirmed_at { Time.now }
    end
  end
end
