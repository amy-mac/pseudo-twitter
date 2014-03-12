require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password 'foobar'
    password_confirmation 'foobar'

    factory :invalid_user do
      name nil
    end
  end

end
