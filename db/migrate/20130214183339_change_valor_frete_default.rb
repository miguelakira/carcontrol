class ChangeValorFreteDefault < ActiveRecord::Migration
  def up
    change_column_default(:debitos, :valor_frete, 0)
  end

  def down
  end
end
