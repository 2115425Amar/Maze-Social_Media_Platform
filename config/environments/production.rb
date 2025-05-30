require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.force_ssl = true
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  # config.hosts << ENV["HOSTNAME"] if ENV["HOSTNAME"].present?
  # config.hosts << "maze-jarvis.onrender.com"
  config.host_authorization = { exclude: ->(request) { true } }

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings (ignored by Rake tasks).
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Turn on fragment caching in view templates.
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry since they are all digest stamped.
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Assume all access to the app is happening through a SSL-terminating reverse proxy.
  config.assume_ssl = true

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Skip http-to-https redirect for the default health check endpoint.
  # config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  # Log to STDOUT with the current request id as a default log tag.
  config.log_tags = [ :request_id ]
  # Old (broken) version
  # config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)

  # New (working) version
config.logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(STDOUT))

  # Change to "debug" to log everything (including potentially personally-identifiable information!)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Prevent health checks from clogging up the logs.
  config.silence_healthcheck_path = "/up"

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Replace the default in-process memory cache store with a durable alternative.
  config.cache_store = :solid_cache_store

  # Replace the default in-process and non-durable queuing backend for Active Job.
  # config.active_job.queue_adapter = :solid_queue
  # config.solid_queue.connects_to = { database: { writing: :queue } }

  config.active_job.queue_adapter = :async

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Only use :id for inspections in production.
  # config.active_record.attributes_for_inspect = [ :id ]

  config.secret_key_base = ENV["SECRET_KEY_BASE"]

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  user_name: "apikey",  # This is literally the word 'apikey', not your actual API key
  # password: Rails.application.credentials.dig(:sendgrid, :api_key),
  password: ENV["SENDGRID_API_KEY"], # Using environment variable
  address: "smtp.sendgrid.net",
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}

# Set host to be used by links generated in mailer templates.
config.action_mailer.default_url_options = { host: "localhost", port: 3000 } # For development
end
