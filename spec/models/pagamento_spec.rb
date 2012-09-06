require 'spec_helper'

describe Pagamento do
  it 'has a valid factory' do
    FactoryGirl.create(:pagamento).should be_valid
  end

  it 'calculates saldo devedor even if it has no taxas' do
  	pagamento = FactoryGirl.build(:pagamento,
  		valor_total: nil,
  		valor_frete: nil,
  		taxa_despacho: nil,
  		taxa_plataforma: nil,
  		desconto: nil,
  		taxa_plataforma_origem: nil,
  		taxa_plataforma_destino: nil,
  		taxa_balsa: nil,
  		valor_pago: nil
  		)
  	pagamento.save 
  	pagamento.saldo_devedor.should == BigDecimal.new(0)
  end

  it 'must calculate saldo_devedor correctly' do
  	pagamento = FactoryGirl.create(:pagamento).saldo_devedor.should == 150
  end

  it 'must calculate valor_total correctly' do
  	pagamento = FactoryGirl.create(:pagamento).valor_total.should  == 300
  end
end