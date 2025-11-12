# Puma config — fixed to avoid duplicate listeners on the same port.
max_threads_count = Integer(ENV.fetch("RAILS_MAX_THREADS", 5))
threads max_threads_count, max_threads_count

environment ENV.fetch("RAILS_ENV", "development")

# Listen on the container's PORT (default 3000). Do NOT also call `bind`.
port Integer(ENV.fetch("PORT", 3000))

# Single-process for dev; Sidekiq runs in a separate container.
workers 0

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
