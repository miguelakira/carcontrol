class AddValueToStatusPagamento < ActiveRecord::Migration
  def change
    add_column :status_pagamentos, :value, :integer
  end
end
