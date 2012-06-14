class CreatePagamentos < ActiveRecord::Migration
  def change
    create_table :pagamentos do |t|
      t.integer :car_id
      t.float :valor_total
      t.float :valor_pago
      t.datetime :data_pagamento
      t.string :forma_pagamento
      t.integer :parcelas
      t.float :valor_entrada

      t.timestamps
    end
  end
end
