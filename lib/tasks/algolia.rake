require 'algoliasearch'

namespace :algolia do
  desc "Send kit records to Algolia"
  task :send_records => :environment do
    puts "Sending data to Algolia..."

    Algolia.init(
      application_id: ENV['ALGOLIA_APPLICATION_ID'],
      api_key: ENV['ALGOLIA_API_KEY']
    )
    index = Algolia::Index.new('kits')

    kits = Kit.all
    records = kits.as_json(
      methods: [:restaurant_photos, :tag_names, :service_urls],
      include: [restaurant: { only: :name}]
    )
    # To be edited to add only new records and keep existing ones (using ObjectID)
    index.replace_all_objects(records)

    puts "Data sent to Algolia."
  end
end
