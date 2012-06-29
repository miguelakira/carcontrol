class AddValorFreteToPagamentos < ActiveRecord::Migration
  def change
    add_column :pagamentos, :valor_frete, :decimal, :precision => 8, :scale => 2
  end
end
