class AddParceiroIdToHistorico < ActiveRecord::Migration
  def change
    add_column :historicos, :parceiro_id, :integer
  end
end
