class AddIdsToPagamentos < ActiveRecord::Migration
  def change
    add_column :pagamentos, :comprador_id, :integer
    add_column :pagamentos, :empresa_id, :integer
  end
end
