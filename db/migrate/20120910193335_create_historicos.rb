class CreateHistoricos < ActiveRecord::Migration
  def change
    create_table :historicos do |t|
      t.string :rota
      t.integer :cegonha_id
      t.datetime :data_entrada
      t.datetime :data_saida
      t.boolean :ativo

      t.timestamps
    end
  end
end
