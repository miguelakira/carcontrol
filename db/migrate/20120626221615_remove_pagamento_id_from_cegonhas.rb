class RemovePagamentoIdFromCegonhas < ActiveRecord::Migration
  def up
  	remove_column :cegonhas, :pagamento_id
  end

  def down
  end
end
