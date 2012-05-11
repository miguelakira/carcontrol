class AddCidadeIdToCars < ActiveRecord::Migration
  def change
    add_column :cars, :cidade_id, :integer
  end
end
