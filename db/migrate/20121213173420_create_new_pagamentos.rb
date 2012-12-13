class CreateNewPagamentos < ActiveRecord::Migration
  def up
    create_table :pagamentos do |t|
      t.integer :comprador_id
      t.integer :empresa_id
      t.float :valor
      t.datetime :data_pagamento
      t.string :forma_pagamento
      t.string :observacao
    end
  end

  def down
  end
end
