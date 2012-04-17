class AddNomeToComprador < ActiveRecord::Migration
  def change
    add_column :compradores, :firstname, :string
    add_column :compradores, :middlename, :string
    add_column :compradores, :lastname, :string
  end
end
