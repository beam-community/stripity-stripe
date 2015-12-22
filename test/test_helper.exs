ExUnit.start
Stripe.start
ExUnit.configure [exclude: [disabled: true], seed: 0 ]

defmodule Helper do
  def create_test_plans do
    Stripe.Plans.create [id: "test-std", name: "Test Plan Standard", amount: 100, interval: "month"]
    Stripe.Plans.create [id: "test-dlx", name: "Test Plan Deluxe", amount: 1000, interval: "month"]
  end
  def create_test_plan id do
    Stripe.Plans.create [id: id, name: "Test Plan #{id}", amount: 100, interval: "month"]
  end
  def delete_test_plan id do
    Stripe.Plans.delete id
  end

  def delete_test_plans do
    Stripe.Plans.delete "test-std"
    Stripe.Plans.delete "test-dlx"
  end

  def create_test_customer( email ) do
    new_customer = [
      email: "#{email}",
      description: "Test Account",
      card: [
        number: "4111111111111111",
        exp_month: 01,
        exp_year: 2018,
        cvc: 123,
        name: "Joe Test User"
      ]
    ]
    {:ok, res} = Stripe.Customers.create new_customer
    res
  end

  def create_test_account(email) do
    new_account = [
      email: email,
      managed: true,
      legal_entity: [
        type: "individual"
      ]
    ]
    {:ok, res} = Stripe.Accounts.create new_account
    res
  end
end

