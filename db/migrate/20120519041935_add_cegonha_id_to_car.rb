class AddCegonhaIdToCar < ActiveRecord::Migration
  def change
    add_column :cars, :cegonha_id, :integer
  end
end
