gen-changelog:
	npx auto-changelog --unreleased

run-all:
	curl -o ./priv/openapi/spec3.sdk.json https://raw.githubusercontent.com/stripe/openapi/master/openapi/spec3.sdk.json
	mix stripe.generate
	mix format
	SKIP_STRIPE_MOCK_RUN=true mix test
