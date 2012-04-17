class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :placa
      t.string :modelo
      t.integer :dono_id
      t.integer :status_pagamento_id
      t.integer :rota_id
      t.string :localizacao

      t.timestamps
    end
  end
end
