class AddParceiroIdToCar < ActiveRecord::Migration
  def change
    add_column :cars, :parceiro_id, :integer
  end
end
