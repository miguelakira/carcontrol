
class AddCegonhaIdToPagamentos < ActiveRecord::Migration
  def change
    add_column :pagamentos, :cegonha_id, :integer
  end
end
