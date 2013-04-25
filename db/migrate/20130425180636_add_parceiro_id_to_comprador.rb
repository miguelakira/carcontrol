class AddParceiroIdToComprador < ActiveRecord::Migration
  def change
    add_column :compradores, :parceiro_id, :integer
  end
end
