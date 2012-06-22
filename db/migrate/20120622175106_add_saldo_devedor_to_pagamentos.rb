class AddSaldoDevedorToPagamentos < ActiveRecord::Migration
  def change
    add_column :pagamentos, :saldo_devedor, :decimal, :precision => 8, :scale => 2
  end
end
