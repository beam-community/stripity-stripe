CURRENT_VERSION := $(shell cat .latest-tag-stripe-openapi-sdk)

download-openapi-current:
	@echo "Tag: $(CURRENT_VERSION)"
	@echo "Downloading https://raw.githubusercontent.com/stripe/openapi/$(CURRENT_VERSION)/openapi/spec3.sdk.json to ./priv/openapi/spec3.sdk.json"
	@curl -o ./priv/openapi/spec3.sdk.json https://raw.githubusercontent.com/stripe/openapi/$(CURRENT_VERSION)/openapi/spec3.sdk.json

generate:
	mix stripe.generate
	mix format

gen-changelog:
	npx auto-changelog --unreleased

run-all:
	@$(eval LATEST_TAG=$(shell curl -s https://api.github.com/repos/stripe/openapi/releases/latest | jq -r '.tag_name'))
	@echo "Latest tag: $(LATEST_TAG)"
	@echo "Downloading https://raw.githubusercontent.com/stripe/openapi/$(LATEST_TAG)/openapi/spec3.sdk.json to ./priv/openapi/spec3.sdk.json"
	@curl -o ./priv/openapi/spec3.sdk.json https://raw.githubusercontent.com/stripe/openapi/$(LATEST_TAG)/openapi/spec3.sdk.json
	mix stripe.generate
	mix format
	SKIP_STRIPE_MOCK_RUN=true mix test
