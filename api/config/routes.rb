# Add this to config/routes.rb

require 'sidekiq/web'

# OPTIONAL basic auth in development (edit the creds as you like)
if Rails.env.development?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    secure_user = ENV.fetch("SIDEKIQ_WEB_USER", "admin")
    secure_pass = ENV.fetch("SIDEKIQ_WEB_PASSWORD", "admin")
    ActiveSupport::SecurityUtils.secure_compare(username, secure_user) &&
      ActiveSupport::SecurityUtils.secure_compare(password, secure_pass)
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => "/admin/sidekiq"

  get "/health/live", to: "health#live"
  get "/health/ready", to: "health#ready"
  resources :payments, only: [:index, :create, :show]
  post "/webhooks/mock", to: "payments#webhook"
end
