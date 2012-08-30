class CreateCidade < ActiveRecord::Migration
  def up
  	create_table :cidades do |t|
    	t.boolean :capital
    	t.string :text
    	t.integer :estado_id
      t.timestamps
  	end
  end

  def down
  end
end
