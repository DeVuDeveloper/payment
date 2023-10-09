require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Payment
  class Application < Rails::Application
    config.load_defaults 7.0
    config.autoload_paths << Rails.root.join("lib")
    config.session_store :cookie_store, key: :cart_data

  end
end
