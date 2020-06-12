require 'test_helper'

class KitsControllerTest < ActionDispatch::IntegrationTest
  Kit.destroy_all
  Restaurant.destroy_all

  restaurant =
    {
      name: "Le Wagon and Sons",
      description:"A fantastic restaurants for coders",
      city:"London",
      postcode: "N5 1EG",
      address1: "123 blackstock road",
      website_url: "https://www.test.com",
      email: "test@test.com"
    }

  kits = [
    {
      name: "Beetroot burger kit",
      description: "Make your own burgers!",
      ingredients: "Burger",
      link_url: "https://www.test.com",
      price: 12.6,
      # restaurant: nil
    },
    {
      name: "Hawaian pizza",
      description: "No one likes pineapple on pizzas",
      ingredients: "Pineapple",
      link_url: "https://www.test2.com",
      price: 8.9,
      # restaurant: restaurant
    }
  ]

  # setup do
  #   testuser1 = User.create(username: 'username1', password: 'password1')
  #   @auth_tokens = auth_tokens_for_user(testuser1)
  #   @header = { "Authorization" => "Bearer #{@auth_tokens}" }
  # end

  # kits.each do |kit|
  #   Kit.create!(kit)
  # end

  test "should get index" do
    get "/kits", headers: @header, as: :json
    assert_response :success
  end

  test "should create kit" do
    post "/restaurants", params: { restaurant: restaurant }, headers: @header, as: :json
    resto = JSON.parse(response.body)
    assert_difference 'Kit.count', 2 do
      kits.each do |x|
        x["restaurant_id"] = resto["id"]
        post "/kits", params: { kit: x }, headers: @header, as: :json
      end
    end

    assert_response 201
  end

  test "should get each kit" do
    Kit.all.each do |x|
      get kit_url(x), headers: @header, as: :json
      assert_response :success
    end

  end
end
