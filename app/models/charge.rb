class Charge
  attr_reader :amount, :customer, :currency, :parking

  def initialize(amount, customer:, currency:, parking:)
    @amount = amount
    @customer = customer
    @currency = currency
    @parking = parking
  end

  def application_fee
    (0.2 * amount).round
  end

  def destination
    parking.customer.account_id
  end

  def save
    stripe_charge = Stripe::Charge.create(
      amount: amount,
      customer: customer,
      currency: currency,
      destination: destination,
      application_fee: application_fee
    )
    stripe_charge.id
  end
end
