class CreateRestaurantTagsTable < ActiveRecord::Migration[6.0]
  def change
    remove_reference :restaurants, :restaurant_category, index: true, foreign_key: true

    drop_table :restaurant_categories

    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :user_restaurants do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    create_table :restaurant_tags do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end
  end
end
