class AddDataCompraToCar < ActiveRecord::Migration
  def change
    add_column :cars, :data_compra, :datetime
  end
end
