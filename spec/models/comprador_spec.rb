require 'spec_helper'

describe Comprador do
  it 'has a valid factory' do
    FactoryGirl.create(:comprador).should be_valid
  end
  it 'is invalid without cpf' do
    FactoryGirl.build(:comprador, cpf: nil ).should_not be_valid
  end
  it 'is invalid without nome' do
    FactoryGirl.build(:comprador, nome: nil).should_not be_valid
  end
  it 'is valid without rg' do
    FactoryGirl.build(:comprador, rg: nil).should be_valid
  end
  it 'does not allow duplicate cpf' do
    comprador = FactoryGirl.create(:comprador)
    FactoryGirl.build(:comprador, cpf: comprador.cpf).should_not be_valid
  end
  it 'returns true if has saldo_devedor > 0' do
    FactoryGirl.build(:comprador_with_cars).devedor?.should == true
    
  end
  it 'returns false if has saldo_devedor == 0' do
    pagamento = FactoryGirl.create(:pagamento, 
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
    cars = Array.new.push(FactoryGirl.create(:car, pagamento: pagamento), FactoryGirl.create(:car, pagamento: pagamento))
    FactoryGirl.build(:comprador, cars: cars).devedor?.should == false
  end
  

end