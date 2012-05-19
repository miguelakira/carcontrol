class AddCidadeEEstadoToCegonha < ActiveRecord::Migration
  def change
    add_column :cegonhas, :cidade_origem, :integer
    add_column :cegonhas, :estado_origem, :integer
    add_column :cegonhas, :cidade_destino, :integer
    add_column :cegonhas, :estado_destino, :integer
    add_column :cegonhas, :cidade_id, :integer
    add_column :cegonhas, :estado_id, :integer
  end
end
