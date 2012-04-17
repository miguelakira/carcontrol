class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :rg
      t.string :email
      t.integer :base_id

      t.timestamps
    end
  end
end
