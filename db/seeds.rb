require_relative 'airtable_loader'


# tag = Tag.create!(name: "Burger")

# resto = Restaurant.create!(name:"Le Wagon and Sons", description:"this is a test description", city:"London", postcode: "N51EG", address1: "123 blackstock road", website_url: "https://www.test.com", email: "test@test.com")

# kit = Kit.new(name:"Beetroot burger Kit", description:"Cook your own burgers", ingredients:"Burger", link_url: "https://www.test.com", price: 12.6)
# kit.restaurant = resto
# kit.save!

# kit_tag = KitTag.new
# kit_tag.kit = kit
# kit_tag.tag = tag
# kit_tag.save!

Restaurant.destroy_all
Kit.destroy_all
Tag.destroy_all
User.destroy_all

puts "Creating User!"
user1 = User.new(username: "rahul")
user1.password = "qwerty"
user1.save!
puts "User Created!"

kits = "https://api.airtable.com/v0/app3vi7yPiL91uvaj/Kits"
restaurants = "https://api.airtable.com/v0/app3vi7yPiL91uvaj/Restaurants"
tags = "https://api.airtable.com/v0/app3vi7yPiL91uvaj/Tags"

kits_data = get_airtable_data(kits)
restaurants_data = get_airtable_data(restaurants)
tags_data = get_airtable_data(tags)

puts "Creating Tags!"
tags_data[:records].each do |record|
  # create a new tag using the tag name attribute from the Airtable response data for tags
  Tag.create!(name: record[:fields][:name])
end
puts "Tags Created!"

puts "Creating Restaurants!"
restaurant_attributes = %i(name description city postcode address1 address2 delivery_options email twitter facebook instagram website_url contact_name)
restaurants_data[:records].each do |record|
  # create new resto using kv pairs that match key from restaurant_attributes list above
  resto = Restaurant.create!(record[:fields].select {|k,v| restaurant_attributes.include?(k)}) 
  # returns array of airtable tag id strings
  resto_tag_ids = record[:fields][:tags] 
  # for each resto_tags_id find the right tag in the airtable API response for tags 
  resto_tag_ids.each do |tag_id|
    tag = tags_data[:records].find { |x| x[:id] == tag_id}
    # find tag in db that matches the name of the tag
    tag = Tag.find_by_name(tag[:fields][:name])
    # create RestaurantTag with each for the restaurant we just created
    RestaurantTag.create!(restaurant: resto, tag: tag)
  end
end
puts "Restaurants Created!"

puts "Creating Kits!"
kit_attributes = %i(name description ingredients link_url price restaurant_id)
kits_data[:records].each do |record|
  # create new resto using kv pairs that match key from kit_attributes list above
  kit = Kit.new(record[:fields].select {|k,v| kit_attributes.include?(k)})
  # store airtable restaurant id (string) for this kit 
  kit_resto_id = record[:fields][:restaurant][0]
  # find restaurant in API response that matches kit resto id above
  restaurant = restaurants_data[:records].find { |x| x[:id] == kit_resto_id}
  # find restaurant in db that matches the name of the restaurant
  restaurant = Restaurant.find_by_name(restaurant[:fields][:name])
  # assign the restaurant to the kit and save
  kit.restaurant = restaurant
  kit.save!
end
puts "Kits Created!"
