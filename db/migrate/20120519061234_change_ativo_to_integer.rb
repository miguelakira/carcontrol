class ChangeAtivoToInteger < ActiveRecord::Migration
  def up
    add_column :cars, :ativo, :integer
  end

  def down
  end
end
