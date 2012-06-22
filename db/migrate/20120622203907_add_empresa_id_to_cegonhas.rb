class AddEmpresaIdToCegonhas < ActiveRecord::Migration
  def change
    add_column :cegonhas, :empresa_id, :integer
  end
end
