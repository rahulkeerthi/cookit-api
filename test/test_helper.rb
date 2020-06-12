ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def auth_tokens_for_user(user)
    # The argument 'user' should be a hash that includes the params 'email' and 'password'.
    post "/login",
      params: 
        { username: user.username, 
          password: user.password 
        },
      as: :json
    # The three categories below are the ones you need as authentication headers.
    JSON.parse(response.body)["jwt"]
  end

  setup do
    testuser1 = User.create(username: 'username1', password: 'password1')
    @auth_tokens = auth_tokens_for_user(testuser1)
    @header = { "Authorization" => "Bearer #{@auth_tokens}" }
  end

end
