require 'test_helper'

class KitsControllerTest < ActionDispatch::IntegrationTest
  Kit.destroy_all
  Restaurant.destroy_all  

  test "should get index" do
    get "/kits", headers: @header, as: :json
    assert_response :success
  end

  test "should create kit" do
    post "/restaurants", params: { restaurant: @restaurants[0] }, headers: @header, as: :json
    resto = JSON.parse(response.body)
    assert_difference 'Kit.count', 2 do
      @kits.each do |x|
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
