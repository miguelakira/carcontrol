class ChangePagamentoDefaults < ActiveRecord::Migration
  def up
    change_column_default(:pagamentos, :saldo, 0)
  end

  def down
  end
end
