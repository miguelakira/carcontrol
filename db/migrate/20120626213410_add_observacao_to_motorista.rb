class AddObservacaoToMotorista < ActiveRecord::Migration
  def change
    add_column :motorista, :observacao, :string
  end
end
