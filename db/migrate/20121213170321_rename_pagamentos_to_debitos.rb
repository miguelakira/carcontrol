class RenamePagamentosToDebitos < ActiveRecord::Migration
  def up
    rename_table :pagamentos, :debitos
  end

  def down
    rename_table :debitos, :pagamentos
  end
end
