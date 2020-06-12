require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  Restaurant.destroy_all

  restaurants = [
    {
      name: "Le Wagon and Sons",
      description:"A fantastic restaurants for coders",
      city:"London",
      postcode: "N5 1EG",
      address1: "123 blackstock road",
      website_url: "https://www.test.com",
      email: "test@test.com"
    },
    {
      name: "Hoxton Eats",
      description:"Hoxton's finest brunch place",
      city:"London",
      postcode: "N43XY",
      address1: "123 Moulmein Road",
      website_url: "https://www.wow.org",
      email: "test@test.org"
    }
  ]

  setup do
    testuser = User.create(username: 'username', password: 'password')
    @auth_tokens = auth_tokens_for_user(testuser)
    @header = { "Authorization" => "Bearer #{@auth_tokens}" }
  end

  test "should get index" do
    get "/restaurants", headers: @header, as: :json
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference 'Restaurant.count', 2 do
      restaurants.each do |x|
        post "/restaurants", params: { restaurant: x }, headers: @header, as: :json
      end
    end

    assert_response 201
  end

  test "should get each restaurant" do
    Restaurant.all.each do |x|
      get restaurant_url(x), headers: @header, as: :json
      assert_response :success
    end
  end
end
