class AddNomeRotaToHistorico < ActiveRecord::Migration
  def change
    remove_column :historicos, :rota
    add_column :historicos, :rota, :integer
    add_column :historicos, :nome_rota, :string

  end
end
