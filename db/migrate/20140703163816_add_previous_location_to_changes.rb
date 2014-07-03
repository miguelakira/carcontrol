class AddPreviousLocationToChanges < ActiveRecord::Migration
  def change
    add_column :changes, :previous_location, :integer
  end
end
