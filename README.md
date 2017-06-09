# Stripe for Elixir [![Build Status](https://travis-ci.org/code-corps/stripity-stripe.svg?branch=2.0)](https://travis-ci.org/code-corps/stripity-stripe) [![Hex.pm](https://img.shields.io/hexpm/v/stripity_stripe.svg?maxAge=2592000)](https://hex.pm/packages/stripity_stripe) [![Hex Docs](https://img.shields.io/badge/hex-docs-9768d1.svg)](https://hexdocs.pm/stripity_stripe) [![Hex.pm](https://img.shields.io/hexpm/dt/stripity_stripe.svg?maxAge=2592000)](https://hex.pm/packages/stripity_stripe) [![Inline docs](http://inch-ci.org/github/code-corps/stripity-stripe.svg)](http://inch-ci.org/github/code-corps/stripity-stripe) [![Coverage Status](https://coveralls.io/repos/github/code-corps/stripity-stripe/badge.svg?branch=master)](https://coveralls.io/github/code-corps/stripity-stripe?branch=2.0)

An Elixir library for working with [Stripe](https://stripe.com/).

Features:

* facilitate using the Connect API (for standalone/managed accounts)
[Stripe Connect](https://stripe.com/docs/connect) by allowing you to supply your
own key. The oauth callback processor (not endpoint) is supplied by this library
as well as a connect button url generator. See below for
[Instructions](#connect).
[Stripe Connect API reference](https://stripe.com/docs/connect/reference)
* TBD

## Stripe API

This library is built on Stripe API version 2016-07-06.
[The docs are up at Hex](http://hexdocs.pm/stripity_stripe/)

## Usage

Install the dependency:

```ex
{:stripity_stripe, "~> 2.0.0"}
```

Next, add to your applications:

```ex
defp application do
  [applications: [:stripity_stripe]]
end
```

## Configuration

To make API calls, it is necessary to configure your Stripe secret key (and
optional platform client id if you are using Stripe Connect):

```ex
use Mix.Config

config :stripity_stripe,
  api_key: "YOUR SECRET KEY",
  connect_client_id: "YOUR CONNECT PLATFORM CLIENT ID"
```

## Testing

All tests have the @tag disabled: false and the test runner is configured to
ignore disabled: true. This helps to turn tests on/off when working in them.

```
mix test
```

## The API

The API attempts to model the official Ruby library as closely as makes sense
while adhering to Elixir syntax and principles.

```ex
{:ok, object} = Stripe.Customer.delete("cus_8Pq6iJMrd4M0AD")
```

For optional arguments, you can send in a Keyword list that will get translated
to parameters. So if you want to update a Subscription, for instance, you must
send in the `customer_id` and `subscription_id` with the list of changes:

```ex
# Change customer to the Premium subscription
{:ok, customer} = Stripe.Customer.update(%{email: "dan@strumber.com"})
```

Metadata (metadata: %{}) key is supported on most object type and allow the
storage of extra information on the stripe platform.

API calls will always return either `{:ok, _record}` or `{:error, error}`.
Errors will be maps directly mirroring
[the Stripe API Error response object](https://stripe.com/docs/api/ruby#errors).

Pagination is available on list calls and follows
[the Stripe API Pagination docs](https://stripe.com/docs/api/ruby#pagination).

```ex
# Example of paging through events
{:ok, events} = Stripe.Customer.list(%{limit: 10})
```

# Connect

Stripe Connect allows you to provide your customers with an easy onboarding to
their own Stripe account. This is useful when you run an e-commerce as a service
platform. Each merchant can transact using their own account using your
platform. Then your platform uses Stripe's API with their own API key obtained
in the onboarding process.

First, you need to register your platform on Stripe Connect to obtain a
`client_id`. In your account settings, there's a "Connect" tab, select it. Then
fill the information to activate your connect platform settings. Then select the
`client_id` (notice there's one for dev and one for prod), stash this
`client_id` in the config file under

```ex
config :stripity_stripe,
  connect_client_id: "ac_???"
```

Then you send your users to sign up for the Stripe account using a link.

Here's an example of a button to start the workflow:
<a href="https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_32D88BD1qLklliziD7gYQvctJIhWBSQ7&scope=read_write">Connect with Stripe</a>

You can generate this URL using:

```ex
url = Stripe.Connect.generate_button_url(%{state: "csrf_token"})
```

When the user gets back to your platform, the following url (`redirect_uri` form
item on your "Connect" settings) will be used:

```
https://yoursvr/your_endpoint?scope=read_write&code=AUTHORIZATION_CODE
```

or

```
https://yoursvr/your_endpoint?error=access_denied&error_description=The%20user%20denied%20your%20request
```

Using the code request parameter, you make the following call:

```ex
{:ok, resp} -> Stripe.Connect.oauth_token_callback(code)
resp[:access_token]
```

## Contributing

Feedback, feature requests, and fixes are welcomed and encouraged.  Please make
appropriate use of [Issues](https://github.com/code-corps/stripity-stripe/issues)
and [Pull Requests](https://github.com/code-corps/stripity-stripe/pulls).  All
code should have accompanying tests.

## License

Please see [LICENSE](LICENSE) for licensing details.
