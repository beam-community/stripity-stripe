# Stripe for Elixir

An Elixir library for working [Stripe](https://stripe.com/).

 - Manage accounts (your own, standalone/managed via connect) [Stripe.Accounts](https://github.com/robconery/stripity-stripe/blob/master/lib/stripe/accounts.ex)
 - Manage customers [Stripe.Customers](https://github.com/robconery/stripity-stripe/blob/master/lib/stripe/customers.ex)
 - Manage Subscriptions [Stripe.Subscriptions](https://github.com/robconery/stripity-stripe/blob/master/lib/stripe/subscriptions.ex)
 - Manage plans [Stripe.Plans](https://github.com/robconery/stripity-stripe/blob/master/lib/stripe/plans.ex)
 - Manage Invoices [Stripe.Invoices](https://github.com/robconery/stripity-stripe/blob/master/lib/stripe/invoices.ex)
 - Manage Invoice Items [Stripe.InvoiceItems](https://github.com/robconery/stripity-stripe/blob/master/lib/stripe/invoice_items.ex)
 - Manage tokens for credit card and bank account [Stripe.Tokens](https://github.com/robconery/stripity-stripe/blob/master/lib/stripe/tokens.ex)
 - List and retrieve stripe events (paged, max 100 per page, up to 30 days kept on stripe for retrieve) [Stripe.Events](https://github.com/robconery/stripity-stripe/blob/master/lib/stripe/events.ex)
 - Manage/capture charges with or without an existing Customer [Stripe.Charges](https://github.com/robconery/stripity-stripe/blob/master/lib/stripe/charges.ex)

- Facilitate using the Connect API (for standalone/managed accounts) [Stripe Connect](https://stripe.com/docs/connect) by allowing you to supply your own key. The oauth callback processor (not endpoint) is supplied by this library as well as a connect button url generator. See below for [Instructions](#connect). [Stripe Connect API reference](https://stripe.com/docs/connect/reference)

- All functions are available with a parameter that allow a stripe api key to be passed in and be used for the underlying request. This api key would be the one obtained by the oauth connect authorize workflow.

Why another Stripe Library? Currently there are a number of them in the Elixir world that are, well just not "done" yet. I started to fork/help but soon it became clear to me that what I wanted was:

 - An existing/better test story
 - An API that didn't just mimic a REST interaction
 - A library that was up to date with Elixir > 1.0 and would, you know, actually *compile*.
 - Function calls that returned a standard `{:ok, result}` or `{:error, message}` response

As I began digging things up with these other libraries it became rather apparent that I was not only tweaking the API, but also ripping out a lot of the existing code... and that usually means I should probably do my own thing. So I did.

## Stripe API

I've tested this library against Stripe API v1 and above. [The docs are up at Hex](http://hexdocs.pm/stripity_stripe/)

Works with API version 2015-10-16

## Usage

Install the dependency:

```ex
{:stripity_stripe, "~> 1.0.0"}
```

Next, add to your applications:

```ex
defp application do
  [applications: [:stripity_stripe]]
end
```

Then create a config folder and add a Stripe secret key (and optional platform client id if you are using Stripe Connect):

```ex
use Mix.Config

config :stripity_stripe, secret_key: "YOUR SECRET KEY"
config :stripity_stripe, platform_client_id: "YOUR CONNECT PLATFORM CLIENT ID"
```

Then add Stripe to your supervisor tree or, to play around, make sure you start it up:

```ex
Stripe.start
```
HTTPoison is started automatically in [Stripe.ex](https://github.com/robconery/stripity-stripe/blob/master/lib/stripe.ex)

## Testing
If you start contributing and you want to run mix test, first you need to export STRIPE_SECRET_KEY environment variable in the same shell as the one you will be running mix test in. All tests have the @tag disabled: false and the test runner is configured to ignore disabled: true. This helps to turn tests on/off when working in them. Most of the tests depends on the order of execution (test random seed = 0) to minimize runtime. I've tried having each tests isolated but this made it take ~10 times longer.
```
export STRIPE_SECRET_KEY="yourkey"
mix test
```

## The API

I've tried to make the API somewhat comprehensive and intuitive. If you'd like to see things in detail be sure to have a look at the tests - they show (generally) the way the API goes together.

In general, if Stripe requires some information for a given API call, you'll find that as part of the arity of the given function. For instance if you want to delete a Customer, you'll find that you *must* pass the id along:

```ex
{:ok, result} = Stripe.Customers.delete "some_id"
```

For optional arguments, you can send in a Keyword list that will get translated to parameters. So if you want to update a Subscription, for instance, you must send in the `customer_id` and `subscription_id` with the list of changes:

```ex
# Change customer to the Premium subscription
{:ok, result} = Stripe.Customers.change_subscription "customer_id", "sub_id", [plan: "premium"]
```

Metadata (metadata:) key is supported on most object type and allow the storage of extra information on the stripe platform. See [test](https://github.com/robconery/stripity-stripe/blob/master/test/stripe/customer_test.exs) for an example.

That's the rule of thumb with this library. If there are any errors with your call, they will bubble up to you in the `{:error, message}` match.

```
# Example of paging through events
{:ok,events} = Stripe.Events.list key, "", 100   #2nd arg is a marker for paging

case events[:has_more] do
    true ->
        # retrieve marker
        last = List.last( events[:data] )
        case Stripe.Events.list key, last["id"], 100 do
            {:ok, events} -> events[:data]
            ...
    false -> events[:data]
end
```
<a name="connect"></a>
# Connect

Stripe Connect allows you to provide your customers with an easy onboarding to
their own Stripe account. This is useful when you run an ecommerce as a service platform. Each merchant can transact using their own account using your platform. Then your platform uses stripity API with their own API key obtained by the onboarding process.

First, you need to register your platform on stripe connect to obtain a client_id.
In your account settings, there's a "Connect" tab, select it. Then fill the information to activate your connect platform settings. The select he client_id (notice there's one for dev and one for prod), stash this client_id in the config file under
config :stripity_stripe, platform_client_id: "ac_???"
or
in an env var named STRIPE_PLATFORM_CLIENT_ID


Then you send your users to sign up for the stripe account using a link.

Here's an example of a button to start the workflow:
<a href="https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_32D88BD1qLklliziD7gYQvctJIhWBSQ7&scope=read_write">Connect with Stripe</a>

You can generate this url using
```
url = Stripe.Connect.generate_button_url csrf_token
```

When the user gets back to your platform, the following url(redirect_uri form item on your "Connect" settings) will be used:

//yoursvr/your_endpoint?scope=read_write&code=AUTHORIZATION_CODE

or

//yoursvr/your_endpoint?error=access_denied&error_description=The%20user%20denied%20your%20request

Using the code request parameter, you make the following call:
```
{:ok, resp} -> Stripe.Connect.oauth_token_callback code
resp[:access_token]
```
resp will look like this
```
%{
    token_type: "bearer",
    stripe_publishable_key: PUBLISHABLE_KEY,
    scope: "read_write",
    livemode: false,
    stripe_user_id: USER_ID,
    refresh_token: REFRESH_TOKEN,
    access_token: ACCESS_TOKEN
}
```

You can then pass the "access_token" to the other API modules to act on their behalf.

See a demo using the phoenix framework with the bare minimum to get this working.[Demo](https://github.com/nicrioux/stripity-connect-phoenix)

# Testing Connect
The tests are currently manual as they require a unique oauth authorization code per test. You need to obtain this code maunally using the stripe connect workflow (that your user would go through using the above url).

First, log in your account. Then go to url
https://dashboard.stripe.com/account/applications/settings

Create a connect standalone account. Grab your development client_id. Put it in your config file. Enter a redirect url to your endpoint. Capture the "code" request parameter. Pass it to Stripe.Connect.oauth_token_callback or Stripe.Connect.get_token.

