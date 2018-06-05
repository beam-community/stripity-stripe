# Latest

## 2.0.0

- official full release after -alpha and -beta releases
- Readme updates related to releasing 2.0 - [#377](https://github.com/code-corps/stripity_stripe/pull/377)
- See the [latest documentation](https://hexdocs.pm/stripity_stripe/api-reference.html) to track what's supported

This is a huge release and we are likely to have missed bugs. Feel free to provide feedback, create issues and contribute with pull requests.

# 1.x.x

## 1.6.2 (2018-06-05)

- Readme updates related to releasing 2.0 - [#372], [#373], [#375]

## 1.6.1 (2018-04-03)

- We now return {:error, data} on request errors, instead of just raising errors - [#343](https://github.com/code-corps/stripity_stripe/pull/343)

## 1.6.0 (2017-07-06)

- Added support to update invoices (`&Stripe.Invoices.change/2`, `&Stripe.Invoices.change/3`) - [#241](https://github.com/code-corps/stripity_stripe/pull/241)
  - credit to https://github.com/TakteS

## 1.5.0 (2017-07-04)

- Added basic webhook support - [#244](https://github.com/code-corps/stripity_stripe/pull/244)

## 1.0.0 to 1.4.0

- Added support to generate connect button URLs - [#231](https://github.com/code-corps/stripity_stripe/pull/231)
- Remaining changes have not been tracked, too many to list.

## 1.0.0 (2015-12-22)

- Bumped version to 1.0.0 as it has become quite feature full and it has a slight breakage factor.
- Stripe Connect standalone account support. All modules were refactored to allow api key to flow thru
- Refactored all subscriptions/invoices to their own modules. Expect a few rough edges there.
- Improved the README
