OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:saml] = OmniAuth::AuthHash.new(
    {
        uid: "user@okta.com"
    }
)

OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
    {
        uid: "user@google.com"

    }
)
