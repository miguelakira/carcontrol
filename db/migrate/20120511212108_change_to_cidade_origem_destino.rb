class ChangeToCidadeOrigemDestino < ActiveRecord::Migration
  def up
    rename_column :cars, :origem, :cidade_origem
    rename_column :cars, :destino, :cidade_destino
    add_column :cars, :estado_origem, :integer
    add_column :cars, :estado_destino, :integer

  end

  def down
  end
end
