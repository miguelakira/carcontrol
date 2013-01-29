class ChangeParenteToComprador < ActiveRecord::Migration
  def change
    add_column :compradores, :parente, :string
    add_column :compradores, :telefone_parente, :string
    remove_column :compradores, :telefone_conhecido
    remove_column :compradores, :conhecido
    remove_column :compradores, :pai
    remove_column :compradores, :mae
  end

  def down
  end
end
