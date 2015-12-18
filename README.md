# Stripe for Elixir

An Elixir library for working with Stripe. With this library you can:

 - manage Customers
 - Create, list, cancel, update and delete Subscriptions
 - Create, list, update and delete Plans
 - Create, list, and update Invoices
 - Create and retrieve tokens for credit card and bank account
 - List and retrieve stripe events (paged, max 100 per page, up to 30 days kept on stripe for retrieve)
 - And yes, run charges with or without an existing Customer

Why another Stripe Library? Currently there are a number of them in the Elixir world that are, well just not "done" yet. I started to fork/help but soon it became clear to me that what I wanted was:

 - An existing/better test story
 - An API that didn't just mimic a REST interaction
 - A library that was up to date with Elixir > 1.0 and would, you know, actually *compile*.
 - Function calls that returned a standard `{:ok, result}` or `{:error, message}` response

As I began digging things up with these other libraries it became rather apparent that I was not only tweaking the API, but also ripping out a lot of the existing code... and that usually means I should probably do my own thing. So I did.

## Stripe API

I've tested this library against Stripe API v1 and above. [The docs are up at Hex](http://hexdocs.pm/stripity_stripe/)

## Usage

Install the dependency:

```
{:stripity_stripe, "~> 0.5.0"}
```

Next, add to your applications:

```ex
defp application do
  [applications: [:stripity_stripe]]
end
```

Then create a config folder and add a Stripe secret key:

```
use Mix.Config

config :stripity_stripe, secret_key: "YOUR SECRET KEY"
```

Then add Stripe to your supervisor tree or, to play around, make sure you start it up:

```
Stripe.start
```

## Testing
If you start contributing and you want to run mix test, first you need to export STRIPE_SECRET_KEY environment variable in the same shell as the one you will be running mix test in.
```
export STRIPE_SECRET_KEY="yourkey"
mix test
```

## The API

I've tried to make the API somewhat comprehensive and intuitive. If you'd like to see things in detail be sure to have a look at the tests - they show (generally) the way the API goes together.

In general, if Stripe requires some information for a given API call, you'll find that as part of the arrity of the given function. For instance if you want to delete a Customer, you'll find that you *must* pass the id along:

```
{:ok, result} = Stripe.Customers.delete "some_id"
```

For optional arguments, you can send in a Keyword list that will get translated to parameters. So if you want to update a Subscription, for instance, you must send in the `customer_id` and `subscription_id` with the list of changes:

```
#Change customer to the Premium subscription
{:ok, result} = Stripe.Customers.change_subscription "customer_id", "sub_id", plan: "premium"
```

```
#Example of paging through events
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
That's the rule of thumb with this library. If there are any errors with your call, they will bubble up to you in the `{:error, message}` match.
