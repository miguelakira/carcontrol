class AddCpfToCompradores < ActiveRecord::Migration
  def change
    add_column :compradores, :cpf, :string
  end
end
