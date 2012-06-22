class AddObservacaoToModels < ActiveRecord::Migration
  def change
  	add_column :cegonhas, :observacao, :string
  	add_column :cars, :observacao, :string
  	add_column :compradores, :observacao, :string
  	add_column :empresas, :observacao, :string
  	add_column :pagamentos, :observacao, :string

  	remove_column :pagamentos, :parcelas
  	remove_column :pagamentos, :valor_entrada
  end
end
