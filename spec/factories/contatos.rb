# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contato do
    especie "MyString"
    nome "MyString"
    telefone "MyString"
    cidade_id 1
    estado_id 1
    comprador_id 1
    email "MyString"
  end
end
