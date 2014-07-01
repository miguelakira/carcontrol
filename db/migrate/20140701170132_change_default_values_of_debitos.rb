class ChangeDefaultValuesOfDebitos < ActiveRecord::Migration
  def up
    change_column :debitos, :valor_total, :decimal, :default => nil
    change_column :debitos, :taxa_despacho, :decimal, :default => nil
    change_column :debitos, :taxa_plataforma, :decimal, :default => nil
    change_column :debitos, :desconto, :decimal, :default => nil
    change_column :debitos, :valor_frete, :decimal, :default => nil
    change_column :debitos, :taxa_plataforma_origem, :decimal, :default => nil
    change_column :debitos, :taxa_plataforma_destino, :decimal, :default => nil
    change_column :debitos, :taxa_balsa, :decimal, :default => nil
  end

  def down
  end
end
