# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require 'rack/cors'

run Rails.application

use Rack::Cors do
 allow do
  origins /https:\/\/\D*cookit\D*.vercel.app/
  resource '*',
    headers: :any,
    methods: [:get, :options, :head],
    expose: ['Authorization']
 end
end