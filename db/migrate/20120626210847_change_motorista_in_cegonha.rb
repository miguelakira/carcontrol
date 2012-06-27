class ChangeMotoristaInCegonha < ActiveRecord::Migration
  def up
  	remove_column :cegonhas, :motorista
    add_column :cegonhas, :nome, :string
  end

  def down
  end
end
