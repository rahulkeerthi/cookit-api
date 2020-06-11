require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  User.destroy_all

  setup do
    @testuser1 = User.create(username: 'testing1', password: 'password')
    @testuser2 = User.create(username: 'testing2', password: 'password')
  end

  test 'user log in' do
    auth = auth_tokens_for_user(@testuser1)
    assert_response :success
  end

end
