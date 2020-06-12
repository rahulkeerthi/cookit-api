require 'test_helper'

class KitsControllerTest < ActionDispatch::IntegrationTest
  Kit.destroy_all

  kits = [
    {
      name: "Beetroot burger kit",
      description: "Make your own burgers!",
      ingredients: "Burger",
      link_url: "https://www.test.com",
      price: 12.6,
      restaurant_id: 1
    },
    {
      name: "Hawaian pizza",
      description: "No one likes pineapple on pizzas",
      ingredients: "Pineapple",
      link_url: "https://www.test2.com",
      price: 8.9,
      restaurant_id: 1
    }
  ]

  setup do
    testuser = User.create(username: 'username', password: 'password')
    @auth_tokens = auth_tokens_for_user(testuser)
    @header = { "Authorization" => "Bearer #{@auth_tokens}" }
  end

  test "should get index" do
    get "/kits", headers: @header, as: :json
    assert_response :success
  end

  test "should create kit" do
    assert_difference 'Kit.count', 2 do
      kits.each do |x|
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
