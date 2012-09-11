class AddCarIdToHistoricos < ActiveRecord::Migration
  def change
    add_column :historicos, :car_id, :integer
  end
end
