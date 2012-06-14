class CreateMotorista < ActiveRecord::Migration
  def change
    create_table :motorista do |t|
      t.string :nome
      t.integer :cegonha_id
      t.string :telefone
      t.string :celular
      t.string :rg
      t.string :cpf
      t.string :email

      t.timestamps
    end
  end
end
