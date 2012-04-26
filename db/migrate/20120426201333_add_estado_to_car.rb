class AddEstadoToCar < ActiveRecord::Migration
  def change
    add_column :cars, :estado_id, :integer
  end
end
