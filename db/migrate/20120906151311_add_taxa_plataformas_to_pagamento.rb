class AddTaxaPlataformasToPagamento < ActiveRecord::Migration
  def change
    add_column :pagamentos, :taxa_plataforma_origem, :decimal, :precision => 8, :scale => 2
    add_column :pagamentos, :taxa_plataforma_destino, :decimal, :precision => 8, :scale => 2
    add_column :pagamentos, :taxa_balsa, :decimal, :precision => 8, :scale => 2
  end
end
