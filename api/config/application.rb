require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    config.load_defaults 7.1
    config.api_only = true
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_interview_practice_session', same_site: :lax, secure: false
  end
end
