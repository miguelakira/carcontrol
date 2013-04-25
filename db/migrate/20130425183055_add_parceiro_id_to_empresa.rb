class AddParceiroIdToEmpresa < ActiveRecord::Migration
  def change
    add_column :empresas, :parceiro_id, :integer
  end
end
