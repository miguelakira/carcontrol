class AddNomeToCars < ActiveRecord::Migration
  def change
    add_column :cars, :nome, :string
  end
end
