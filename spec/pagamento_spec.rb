require 'spec_helper'

describe Pagamento do
  it 'has a valid factory' do
    FactoryGirl.create(:pagamento).should be_valid
  end
end