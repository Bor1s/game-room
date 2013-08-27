# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    user_id "MyString"
    room_id "MyString"
    role 1
  end
end
