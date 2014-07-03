class CreateChanges < ActiveRecord::Migration
  def change
    create_table :changes do |t|
      t.integer :tracking_id
      t.integer :current_location
      t.string :current_cars

      t.timestamps
    end
  end
end
