class ChangePricesToBigDecimal < ActiveRecord::Migration
  def up
    remove_column :pagamentos, :valor_total, :valor_pago, :valor_entrada
    add_column :pagamentos, :valor_total, :decimal, :precision => 8, :scale => 2
    add_column :pagamentos, :valor_pago, :decimal, :precision => 8, :scale => 2
    add_column :pagamentos, :valor_entrada, :decimal, :precision => 8, :scale => 2
  end

  def down
  end
end
