# Stripe for Elixir 

[![Build Status](https://travis-ci.org/code-corps/stripity-stripe.svg?branch=master)](https://travis-ci.org/code-corps/stripity-stripe) [![Hex.pm](https://img.shields.io/hexpm/v/stripity_stripe.svg?maxAge=2592000)](https://hex.pm/packages/stripity_stripe) [![Hex Docs](https://img.shields.io/badge/hex-docs-9768d1.svg)](https://hexdocs.pm/stripity_stripe) [![Hex.pm](https://img.shields.io/hexpm/dt/stripity_stripe.svg?maxAge=2592000)](https://hex.pm/packages/stripity_stripe) [![Inline docs](http://inch-ci.org/github/code-corps/stripity-stripe.svg)](http://inch-ci.org/github/code-corps/stripity-stripe) [![Coverage Status](https://coveralls.io/repos/github/code-corps/stripity-stripe/badge.svg?branch=master)](https://coveralls.io/github/code-corps/stripity-stripe?branch=master)

An Elixir library for working with [Stripe](https://stripe.com/).

# Which version should I use?

The old `1.x.x` line of releases has been kept and is being published separately for backwards compatibility, since `2.0` was a complete rewrite. To contribute to that line (bugfixes, mainly), create pull requests against the `1.x.x` branch.

The actively developed line of releases is `2.x.x` and is contained within the `master` branch. New features are being added to this line of releases, so to develop this library further, create pull requests against the master branch.

# Documentation

- [1.x.x](https://hexdocs.pm/stripity_stripe/1.6.1/)
- [Latest](https://hexdocs.pm/stripity_stripe/)

## Stripe API

Works with API version 2015-10-16

## Installation

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

To make API calls, it is necessary to configure your Stripe secret key (and optional platform client id if you are using Stripe Connect):

```ex
use Mix.Config

config :stripity_stripe, secret_key: "YOUR SECRET KEY"
config :stripity_stripe, platform_client_id: "YOUR CONNECT PLATFORM CLIENT ID"
```

To customize the underlying HTTPoison library, you may optionally add an `:httpoison_options` key to the stripity_stripe configuration.  For a full list of configuration options, please refer to the [HTTPoison documentation](https://github.com/edgurgel/httpoison).

```ex
config :stripity_stripe, httpoison_options: [timeout: 10000, recv_timeout: 10000, proxy: {"proxy.mydomain.com", 8080}]
```

## Testing

If you start contributing and you want to run mix test, first you need to export STRIPE_SECRET_KEY environment variable in the same shell as the one you will be running mix test in. All tests have the @tag disabled: false and the test runner is configured to ignore disabled: true. This helps to turn tests on/off when working in them. Most of the tests depends on the order of execution (test random seed = 0) to minimize runtime. I've tried having each tests isolated but this made it take ~10 times longer.

```
export STRIPE_SECRET_KEY="yourkey"
mix test
```

# Contributing

Feedback, feature requests, and fixes are welcomed and encouraged.  Please make appropriate use of [Issues](https://github.com/code-corps/stripity-stripe/issues) and [Pull Requests](https://github.com/code-corps/stripity-stripe/pulls).  All code should have accompanying tests.

# License

Please see [LICENSE](LICENSE) for licensing details.

# History

## Statement from original author

Why another Stripe Library? Currently there are a number of them in the Elixir world that are, well just not "done" yet. I started to fork/help but soon it became clear to me that what I wanted was

* an existing/better test story
* an API that didn't just mimic a REST interaction
* a library that was up to date with Elixir > 1.0 and would, you know, actually *compile*.
* function calls that returned a standard `{:ok, result}` or `{:error, message}` response

As I began digging things up with these other libraries it became rather apparent that I was not only tweaking the API, but also ripping out a lot of the existing code... and that usually means I should probably do my own thing. So I did.

## Update

As of October 18th, Rob has graciously handed over the reins to the teams at [Code Corps](https://www.codecorps.org/) and [Strumber](https://strumber.com/). To addresses the concerns Rob mentioned above and update the high level api to work with all of the Stripe API Endpoints, they have since worked to release and stripity_stripe 2.0, which is now the actively developed line of releases.
