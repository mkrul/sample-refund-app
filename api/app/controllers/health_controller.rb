class HealthController < ApplicationController
  def live
    render json: { ok: true }
  end
  def ready
    ActiveRecord::Base.connection.execute("SELECT 1")
    render json: { ok: true }
  end
end
