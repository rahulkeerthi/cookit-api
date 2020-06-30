# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: true, logger: (-> { Rails.logger }) do
  allow do
    origins [/https:\/\/\D*cookit\D*.vercel.app/, /http:\/\/\D*cookit\D*.vercel.app/, "https://localhost:3000", "https://localhost:3001", "http://localhost:3000", "http://localhost:3001"]

    resource '*',
      headers: :any,
      methods: [:get, :options, :head],
      expose: ['Authorization', 'Accept', 'Content-Type']
  end
end

