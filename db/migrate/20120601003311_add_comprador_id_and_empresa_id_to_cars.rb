class AddCompradorIdAndEmpresaIdToCars < ActiveRecord::Migration
  def change
    add_column :cars, :comprador_id, :integer
    add_column :cars, :empresa_id, :integer
    remove_column :compradores, :car_id
    remove_column :empresas, :car_id
  end
end
