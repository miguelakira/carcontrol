class CreateCompradores < ActiveRecord::Migration
  def change
    create_table :compradores do |t|
      t.string :nome
      t.string :email
      t.string :rg
      t.string :telefone
      t.string :celular

      t.timestamps
    end
  end
end
