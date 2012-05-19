class ChangeAtivoToInteger < ActiveRecord::Migration
  def up
    remove_column :cars, :ativo
    add_column :cars, :ativo, :integer
  end

  def down
  end
end
