Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
      :idp_sso_target_url                 => ENV['OKTA_LOGIN_URL'],
      :idp_sso_target_url_runtime_params  => {:original_request_param => :mapped_idp_param},
      :idp_cert_fingerprint               => ENV['OKTA_CERT_FINGERPRINT']
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, 'GOOGLE_CLIENT_ID', 'GOOGLE_CLIENT_SECRET'
end
