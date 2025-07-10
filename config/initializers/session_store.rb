Rails.application.config.session_store :cookie_store,
  key: "_sms_messenger_session",
  same_site: :none,
  secure: true
