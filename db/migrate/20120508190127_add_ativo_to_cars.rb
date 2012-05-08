class AddAtivoToCars < ActiveRecord::Migration
  def change
    add_column :cars, :ativo, :boolean
  end
end
