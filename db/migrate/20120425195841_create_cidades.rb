class CreateCidades < ActiveRecord::Migration
  def change
      create_table :cidades do |t|
        t.string :nome
        t.integer :estado_id
        t.integer :capital
        t.timestamps
      end
    end
  end
end
