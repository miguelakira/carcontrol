class AddPagamentoIdToCegonhas < ActiveRecord::Migration
  def change
    add_column :cegonhas, :pagamento_id, :integer
  end
end
