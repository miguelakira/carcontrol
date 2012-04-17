class AddCarIdToComprador < ActiveRecord::Migration
  def change
    add_column :compradores, :car_id, :integer
    remove_column :cars, :comprador_id
  end
end
