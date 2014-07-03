# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :change do
    tracking_id false
    current_location 1
    current_cars "MyString"
  end
end
