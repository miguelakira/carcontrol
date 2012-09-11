class CreateParceiros < ActiveRecord::Migration
  def change
    create_table :parceiros do |t|
      t.integer :carros
      t.string :contato
      t.string :nome
      t.string :telefone
      t.string :celular
      t.string :localizacao
      t.integer :cidade_origem
      t.integer :cidade_destino
      t.integer :estado_origem
      t.integer :estado_destino
      t.integer :cidade_id
      t.integer :estado_id
      t.string :comentario

      t.timestamps
    end
  end
end
