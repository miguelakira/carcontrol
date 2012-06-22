class AddDataPrevistaToCars < ActiveRecord::Migration
  def change
    add_column :cars, :data_prevista, :datetime
  end
end
