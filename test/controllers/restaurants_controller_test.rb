require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  Restaurant.destroy_all

  test "should get index" do
    get "/restaurants", headers: @header, as: :json
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference 'Restaurant.count', 2 do
      @restaurants.each do |x|
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
