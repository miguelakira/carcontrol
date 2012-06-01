class AddMotoristaToCegonha < ActiveRecord::Migration
  def change
    add_column :cegonhas, :motorista, :string
  end
end
