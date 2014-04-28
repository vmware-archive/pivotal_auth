require 'okta_saml/constants'

#We're overriding their constants because we cannot specify staging vs production vars
# without introducing a whole new rails env

SAML_SETTINGS[:idp_sso_target_url] = ENV['OKTA_LOGIN_URL']
SAML_SETTINGS[:idp_cert_fingerprint] = ENV['OKTA_CERT_FINGERPRINT']

