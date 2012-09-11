class AddLocalizacaoToHistorico < ActiveRecord::Migration
  def change
    add_column :historicos, :localizacao_entrada, :string
    add_column :historicos, :localizacao_saida, :string
  end
end
