# #These two lines prevented deployment to heroku, need to look into affect later
# require 'dotenv'
# Dotenv.load
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MentorMenteePlatform
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    config.load_defaults 5.1
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins ['http://localhost', 'http://localhost:3000']
        resource '*', headers: :any, methods: %i[get post options]
      end
    end
    # Handle temporary files in docker, want to avoid storing them as root on home machine.

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rbls files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
