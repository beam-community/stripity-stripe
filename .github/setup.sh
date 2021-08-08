if [ ! -d "stripe-mock/stripe-mock_${STRIPE_MOCK_VERSION}" ]; then
    mkdir -p stripe-mock/stripe-mock_${STRIPE_MOCK_VERSION}/
    curl -L "https://github.com/stripe/stripe-mock/releases/download/v${STRIPE_MOCK_VERSION}/stripe-mock_${STRIPE_MOCK_VERSION}_linux_amd64.tar.gz" -o "stripe-mock/stripe-mock_${STRIPE_MOCK_VERSION}_linux_amd64.tar.gz"
    tar -zxf "stripe-mock/stripe-mock_${STRIPE_MOCK_VERSION}_linux_amd64.tar.gz" -C "stripe-mock/stripe-mock_${STRIPE_MOCK_VERSION}/"
fi