class ChangeNomeToTextInCidade < ActiveRecord::Migration
  def up
    rename_column :cidades, :nome, :text
  end

  def down
  end
end
