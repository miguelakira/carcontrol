class AddParentesToComprador < ActiveRecord::Migration
  def change
    add_column :compradores, :pai, :string
    add_column :compradores, :mae, :string
    add_column :compradores, :telefone_conhecido, :string
    add_column :compradores, :conhecido, :string
  end
end
