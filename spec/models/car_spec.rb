require 'spec_helper'

describe Car do 
  it 'has a valid factory' do
    FactoryGirl.create(:car).should be_valid
  end
  it 'is invalid without a placa' do
    FactoryGirl.build(:car, placa: nil).should_not be_valid
  end
  it 'does not allow duplicate placas' do
    car = FactoryGirl.create(:car)
    FactoryGirl.build(:car, placa: car.placa).should_not be_valid
  end
  it 'is invalid without a modelo' do
    FactoryGirl.build(:car, modelo: nil).should_not be_valid
  end
  
  it 'is invalid if nome of comprador is nil' 
  it 'is invalid if belongs to cegonha when inactive' 

  
  describe 'verify letter cases of car' do
    before :each do
      @placa = 'aaa-0000'
      @modelo = 'CHEVROLET CELTA'
    end

    context 'correct letter cases' do
      it 'is valid if placa is upcased' do
        FactoryGirl.create(:car, placa: @placa).placa.should == @placa.upcase
      end

      it 'is valid if modelo is downcased' do
        FactoryGirl.create(:car, modelo: @modelo).modelo.should == @modelo.downcase
      end

      it 'is valid if modelo is titleized' do
        FactoryGirl.create(:car, modelo: @modelo)
        Car.last.modelo.should == @modelo.titleize
      end
    end

    context 'incorrect letter cases' do
      it 'is invalid if placa is downcased' do
        FactoryGirl.create(:car, placa: @placa).placa.should_not == @placa.downcase
      end

      it 'is invalid if modelo is upcased' do
        FactoryGirl.create(:car, modelo: @modelo).modelo.should_not == @modelo.upcase
      end

      it 'is invalid if modelo is not titleized' do
        FactoryGirl.create(:car, modelo: @modelo)
        Car.last.modelo.should_not == @modelo
      end

    end
  end
  
  

  
end