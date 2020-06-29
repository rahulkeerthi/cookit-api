class AddCounterAndPortionSizeToKits < ActiveRecord::Migration[6.0]
  def change
    add_column :kits, :counter, :integer, null: false, default: 0
    add_column :kits, :serves_count, :integer
  end
end
