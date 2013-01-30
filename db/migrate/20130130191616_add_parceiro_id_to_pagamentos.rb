class AddParceiroIdToPagamentos < ActiveRecord::Migration
  def change
    add_column :pagamentos, :parceiro_id, :integer
  end
end
