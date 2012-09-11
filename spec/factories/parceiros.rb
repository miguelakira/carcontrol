# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parceiro do
    carros 1
    contato "MyString"
    nome "MyString"
    telefone "MyString"
    celular "MyString"
    localizacao "MyString"
    cidade_origem 1
    cidade_destino 1
    estado_origem 1
    estado_destino 1
    cidade_id 1
    estado_id 1
    comentario "MyString"
  end
end
