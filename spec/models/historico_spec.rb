require 'spec_helper'

describe Historico do
	it 'has a valid factory' do
		FactoryGirl.create(:historico).should be_valid
	end

	it 'becomes inactive when data_final is not empty' do
		historico = FactoryGirl.build(:historico, 
			data_final: Time.now
			)
		#historico.save
		
		historico.ativo.should be_false
	end

	it 'adds a new car_id to historico when a car is put on a cegonha'
	it 'never removes any car from historico'


end
