FactoryGirl.define do 
  factory :comprador do
    nome "John Doe"
    sequence(:email) { |n| "johndoe#{n}@email.com"}
    sequence(:cpf) { |n| "123.644.318-#{n+10}"}
    rg '410644225'
    cars do |c|
      [c.association(:car), c.association(:car)]
    end

  end
  
end