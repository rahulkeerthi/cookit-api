class CreateKits < ActiveRecord::Migration[6.0]
  def change
    create_table :kits do |t|
      t.string :name
      t.text :description
      t.string :ingredients
      t.string :link_url
      t.float :price
      t.references :kit_category, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
