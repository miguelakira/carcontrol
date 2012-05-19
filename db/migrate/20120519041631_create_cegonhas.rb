class CreateCegonhas < ActiveRecord::Migration
  def change
    create_table :cegonhas do |t|
      t.string :placa
      t.string :localizacao
      t.string :origem
      t.string :destino
      t.integer :carros
      t.string :comentario

      t.timestamps
    end
  end
end
