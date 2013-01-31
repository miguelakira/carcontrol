class ChangeDebitoDefaults < ActiveRecord::Migration
  def up
    change_column_default(:debitos, :valor_total, 0)
    change_column_default(:debitos, :taxa_despacho, 0)
    change_column_default(:debitos, :taxa_plataforma, 0)
    change_column_default(:debitos, :taxa_plataforma_origem, 0)
    change_column_default(:debitos, :taxa_plataforma_destino, 0)
    change_column_default(:debitos, :desconto, 0)
    change_column_default(:debitos, :saldo_devedor, 0)
    change_column_default(:debitos, :taxa_balsa, 0)
  end

  def down
    change_column_default(:debitos, :valor_total, nil)
    change_column_default(:debitos, :taxa_despacho, nil)
    change_column_default(:debitos, :taxa_plataforma, nil)
    change_column_default(:debitos, :taxa_plataforma_origem, nil)
    change_column_default(:debitos, :taxa_plataforma_destino, nil)
    change_column_default(:debitos, :desconto, nil)
    change_column_default(:debitos, :saldo_devedor, nil)
    change_column_default(:debitos, :taxa_balsa, nil)
  end
end
