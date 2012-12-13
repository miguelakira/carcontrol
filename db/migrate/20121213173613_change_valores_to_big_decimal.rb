class ChangeValoresToBigDecimal < ActiveRecord::Migration
  def up
    remove_column :pagamentos, :valor
    add_column :pagamentos, :valor, :decimal, :precision => 8, :scale => 2
  end

  def down
  end
end
