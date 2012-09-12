class AddCpfToParceiro < ActiveRecord::Migration
  def change
    add_column :parceiros, :cpf, :string
  end
end
