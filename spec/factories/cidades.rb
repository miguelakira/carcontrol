FactoryGirl.define do
  factory :cidade do
    association :estado
    capital true
    text "Sorocaba"
  end
end