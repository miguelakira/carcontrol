class AddObservacaoToParceiro < ActiveRecord::Migration
  def change
    remove_column :parceiros, :comentario
    add_column :parceiros, :observacao, :string
  end
end
