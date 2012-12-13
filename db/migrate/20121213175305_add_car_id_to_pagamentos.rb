class AddCarIdToPagamentos < ActiveRecord::Migration
  def change
    add_column :pagamentos, :car_id, :integer
  end
end
