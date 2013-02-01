class AddSaldoToPagamento < ActiveRecord::Migration
  def change
    add_column :pagamentos, :saldo, :decimal, :precision => 8, :scale => 2
  end
end
