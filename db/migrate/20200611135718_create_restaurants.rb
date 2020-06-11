class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.float :map_lat
      t.float :map_long
      t.string :city
      t.string :postcode
      t.string :address1
      t.string :address2
      t.text :description
      t.string :delivery_options
      t.references :restaurant_category, null: false, foreign_key: true
      t.string :email
      t.string :twitter
      t.string :facebook
      t.string :instagram
      t.string :website_url
      t.string :contact_name

      t.timestamps
    end
  end
end
