OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:saml] = OmniAuth::AuthHash.new(
    {
        uid: "user@test.com"
    }
)
