## 1.6.0 (2017-07-06)

Changes:

- Added support to update invoices (`&Stripe.Invoices.change/2`, `&Stripe.Invoices.change/3`)
  - https://github.com/code-corps/stripity_stripe/pull/241
  - credit to https://github.com/TakteS

## 1.5.0 (2017-07-04)

Changes:

- Added basic webhook support - https://github.com/code-corps/stripity_stripe/pull/244

## 1.0.0 to 1.4.0

- Sadly the changes have not been properly tracked here. We will compile a list
as soon as we are able

## 1.0.0 (2015-12-22)

Changes:

- Bumped version to 1.0.0 as it has become quite feature full and it has a slight breakage factor.
- Stripe Connect standalone account support. All modules were refactored to allow api key to flow thru
- Refactored all subscriptions/invoices to their own modules. Expect a few rough edges there.
- Improved the README
