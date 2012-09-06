FactoryGirl.define do
  factory :pagamento do
    valor_pago 100.0
    desconto 50
    taxa_despacho 50
    taxa_plataforma 50
    valor_frete 50
    taxa_plataforma_origem 50
    taxa_plataforma_destino 50
    taxa_balsa 50
  end
end