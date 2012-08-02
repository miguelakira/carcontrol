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
    FactoryGirl.build(:comprador).devedor?.should == true
  end
  it 'returns false if has saldo_devedor == 0' do
    pagamento = FactoryGirl.create(:pagamento, 
      valor_pago: 0, taxa_despacho: 0, taxa_plataforma: 0, valor_frete: 0, desconto: 0
      )
    cars = Array.new.push(FactoryGirl.create(:car, pagamento: pagamento), FactoryGirl.create(:car, pagamento: pagamento))
    FactoryGirl.build(:comprador, cars: cars).devedor?.should == false
  end
  

end