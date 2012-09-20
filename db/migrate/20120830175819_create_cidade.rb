class CreateCidade < ActiveRecord::Migration
  def up
  	unless table_exists? :cidades
      create_table :cidades do |t|
      	t.boolean :capital
      	t.string :text
      	t.integer :estado_id
        t.timestamps
    	end
    end
  end

  def down
  end
end
