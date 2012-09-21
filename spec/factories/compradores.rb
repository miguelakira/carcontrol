FactoryGirl.define do 
  factory :comprador do
    nome "John Doe"
    sequence(:email) { |n| "johndoe#{n}@email.com"}
    sequence(:cpf) { |n| "123.644.318-#{n+10}"}
    rg '410644225'

  end
  
  factory :comprador_with_cars, :parent => :comprador do
    after_build do |o|
        o.cars = [FactoryGirl.build(:car, :comprador => o), FactoryGirl.build(:car, :comprador => o)]
    end
  end

end