class AddCnpjToParceiro < ActiveRecord::Migration
  def change
    add_column :parceiros, :cnpj, :string
  end
end
