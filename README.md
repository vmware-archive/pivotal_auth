# PivotalAuth

## Setup

To install, add these two lines to your Gemfile:

	gem "pivotal_auth", github: "pivotal/pivotal_auth"
	gem "okta_saml", github: "pivotal/okta_saml", branch: "dev"

Add this line in your routes:

	mount PivotalAuth::Engine, at: '/'

Make sure you also have a root route defined. This is where users will be redirected to after login, unless they have previously visited a page that requires authentication.

Run these lines:

	bundle
	rails g pivotal_auth:init
	
Ignore the "Missing okta_saml.yml file in Rails.root/config" warning.

## Environment Variables and Okta Setup

The gem requires two env variables: `OKTA_LOGIN_URL` and `OKTA_CERT_FINGERPRINT`. These are specific to the Okta app you are authenticating against.

To get these values, follow the [instructions](https://github.com/primedia/okta_saml#okta-configuration) under "Okta Configuration" and "Configuration". Step 1 of the "Configuration" instructions refers to `OKTA_LOGIN_URL`. Step 2 of the instructions refers to `OKTA_CERT_FINGERPRINT`.

## Routes

- Login: `/login`
- Logout: `/logout`

## Useful Controller/View Helper Methods

- `current_user_email` - Returns the email of the currently logged in user.
- `user_signed_in?` - Returns if a user is signed in
- `authenticate_user!` - A before filter that will redirect to '/login' if no user is signed in. It will also set a redirect url to the current path.

## Mocking

You can mock out the actual network calls by using the OmniAuth mocking support:

``` ruby
OmniAuth.config.test_mode = true
```

...and in your specs, setup each user before attempting to login:

```
OmniAuth.config.add_mock(:default, {:info => {:email => "#{name}@pivotallabs.com"}})
```

Bonus points for adding webmock:

```
WebMock.disable_net_connect!
```
