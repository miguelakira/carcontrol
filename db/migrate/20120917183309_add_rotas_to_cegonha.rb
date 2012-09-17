class AddRotasToCegonha < ActiveRecord::Migration
  def change
    add_column :cegonhas, :rotas, :integer, :default => 1
  end
end
