class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :nome
      t.string :cnpj
      t.string :email
      t.string :telefone
      t.string :celular
      t.string :contato
      t.integer :car_id
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
