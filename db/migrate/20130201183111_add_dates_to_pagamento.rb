class AddDatesToPagamento < ActiveRecord::Migration
  def change
    add_column :pagamentos, :created_at, :datetime
    add_column :pagamentos, :updated_at, :datetime
  end
end
