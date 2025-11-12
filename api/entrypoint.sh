#!/usr/bin/env bash
set -euo pipefail
export PORT="${PORT:-3000}"
bundle check || bundle install
./bin/rails db:prepare
exec bundle exec puma -C config/puma.rb
