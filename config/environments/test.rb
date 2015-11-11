Rails.application.configure do
  config.cache_classes = true
  config.eager_load = false
  config.serve_static_files   = true
  config.static_cache_control = 'public, max-age=3600'
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.action_mailer.delivery_method = :test
  config.active_support.test_order = :random
  config.active_support.deprecation = :stderr
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    user_name: 'kirill.test.gus',
    password: 'test123test',
    authentication: 'plain',
    enable_starttls_auto: true
  }

  config.action_mailer.default_url_options = { host: "localhost:3000" }
end
