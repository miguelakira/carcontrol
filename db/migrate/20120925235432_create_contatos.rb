class CreateContatos < ActiveRecord::Migration
  def change
    create_table :contatos do |t|
      t.string :especie
      t.string :nome
      t.string :telefone
      t.integer :cidade_id
      t.integer :estado_id
      t.integer :comprador_id
      t.string :email

      t.timestamps
    end
  end
end
