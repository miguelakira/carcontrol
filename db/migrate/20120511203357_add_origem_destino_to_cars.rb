class AddOrigemDestinoToCars < ActiveRecord::Migration
  def change
    add_column :cars, :origem, :integer
    add_column :cars, :destino, :integer
  end
end
