FactoryGirl.define do
  factory :pagamento do
    valor_pago 100.50
    taxa_despacho 10.5
    taxa_plataforma 5.5
    desconto 5.5
    valor_frete 300.50
  end
end