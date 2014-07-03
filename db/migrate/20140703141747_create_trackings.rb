class CreateTrackings < ActiveRecord::Migration
  def change
    create_table :trackings do |t|
      t.integer :origin
      t.integer :destination
      t.integer :cegonha_id
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :active

      t.timestamps
    end
  end
end
