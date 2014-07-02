class RemoveValorTotalFromDebito < ActiveRecord::Migration
  def up
    remove_column :debitos, :valor_total
  end

  def down
  end
end
