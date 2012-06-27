class AddMotoristaIdToCegonhas < ActiveRecord::Migration
  def change
    add_column :cegonhas, :motorista_id, :integer
    remove_column :motorista, :cegonha_id
  end
end
