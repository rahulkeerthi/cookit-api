class RemoveKitCategoryReferenceAndTable < ActiveRecord::Migration[6.0]
  def change
    remove_reference :kits, :kit_category, index: true, foreign_key: true

    drop_table :kit_categories
  end
end
