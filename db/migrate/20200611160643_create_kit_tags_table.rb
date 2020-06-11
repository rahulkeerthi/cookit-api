class CreateKitTagsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :kit_tags do |t|
      t.references :kit, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end
  end
end
