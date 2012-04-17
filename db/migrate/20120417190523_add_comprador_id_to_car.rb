class AddCompradorIdToCar < ActiveRecord::Migration
  def change
    add_column :cars, :comprador_id, :integer
    remove_column :cars, :dono_id
  end
end
