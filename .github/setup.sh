if [ ! -d "stripe-mock/stripe-mock_0.95.0" ]; then
    mkdir -p stripe-mock/stripe-mock_0.95.0/
    curl -L "https://github.com/stripe/stripe-mock/releases/download/v0.95.0/stripe-mock_0.95.0_linux_amd64.tar.gz" -o "stripe-mock/stripe-mock_0.95.0_linux_amd64.tar.gz"
    tar -zxf "stripe-mock/stripe-mock_0.95.0_linux_amd64.tar.gz" -C "stripe-mock/stripe-mock_0.95.0/"
fi