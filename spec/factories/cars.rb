FactoryGirl.define do
  factory :car do
    association :pagamento
    association :comprador
    modelo "Ford Ka"  
    status_pagamento_id 1
    estado_id 1
    cidade_id 20
    cidade_origem 1
    cidade_destino 10
    estado_origem 1
    estado_destino 1
    ativo 1
    observacao "nenhuma observacao relevante"
    nome "john doe" 
    sequence(:placa) { |n| "DFQ-12#{n+10}"}
  end
end