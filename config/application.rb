require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JTurbochat
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.action_view.sanitized_allowed_tags = Loofah::HTML5::SafeList::ALLOWED_ELEMENTS
    config.action_view.sanitized_allowed_attributes = Loofah::HTML5::SafeList::ALLOWED_ATTRIBUTES
    
    # Configuration for the application, engines, and railties goes here.
    config.active_storage.variant_processor = :mini_magick
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
