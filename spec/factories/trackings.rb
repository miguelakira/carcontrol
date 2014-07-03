# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tracking do
    origin "MyString"
    destination "MyString"
    cegonha_id 1
    start_date "2014-07-03 11:17:47"
    end_date "2014-07-03 11:17:47"
    active false
  end
end
