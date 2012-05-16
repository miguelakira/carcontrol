class AddAtivoToCar < ActiveRecord::Migration
  def change
    add_column :cars, :ativo, :boolean
  end
end
