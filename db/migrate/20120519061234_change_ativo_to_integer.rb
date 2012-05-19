class ChangeAtivoToInteger < ActiveRecord::Migration
  def up
    change_column :cars, :ativo, :integer

  end

  def down
  end
end
