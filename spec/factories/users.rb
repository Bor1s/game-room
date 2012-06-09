# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "#{SecureRandom.hex(5)}@gmail.com"
    password "1234567"
  end
end
