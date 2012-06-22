class AddTaxasToPagamentos < ActiveRecord::Migration
  def change
    add_column :pagamentos, :taxa_despacho, :decimal, :precision => 8, :scale => 2
    add_column :pagamentos, :taxa_plataforma, :decimal, :precision => 8, :scale => 2
    add_column :pagamentos, :desconto, :decimal, :precision => 8, :scale => 2
  end
end
