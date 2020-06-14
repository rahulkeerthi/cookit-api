
require 'net/http'
require 'uri'
require 'json'

def get_airtable_data(url)
  # Parse the URL into a URI and set up the request
  uri = URI.parse(url)
  request = Net::HTTP::Get.new(uri)
  #! replace the bearer token with an ENV variable
  request["Authorization"] = "Bearer " + ENV["AIRTABLE_TOKEN"]
  
  # use SSL to make the request
  req_options = {
    use_ssl: uri.scheme == "https",
  }
  
  # make the request and save the response
  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
  # parse the response payload into JSON and symbolize all keys (deeply) 
  JSON.parse(response.body, symbolize_names: true)
end

# restaurants = "https://api.airtable.com/v0/app3vi7yPiL91uvaj/Restaurants"
# data = get_airtable_data(restaurants)

