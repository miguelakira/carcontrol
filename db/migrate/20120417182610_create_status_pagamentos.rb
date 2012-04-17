class CreateStatusPagamentos < ActiveRecord::Migration
  def change
    create_table :status_pagamentos do |t|
      t.string :status

      t.timestamps
    end
  end
end
