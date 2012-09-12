class AddEmailToParceiro < ActiveRecord::Migration
  def change
    add_column :parceiros, :email, :string
  end
end
