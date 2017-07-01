class Charge
  attr_reader :amount, :customer, :currency, :parking

  def initialize(amount:, customer:, currency:, parking:)
    @amount = amount
    @customer = customer
    @currency = currency
    @parking = parking
  end

  def self.application_fee(amount)
    (0.30 * amount).round(2)
  end

  def save
    stripe_charge = Stripe::Charge.create(
      amount: amount,
      customer: customer,
      currency: currency,
      destination: destination,
      application_fee: application_fee_cents
    )
    stripe_charge.id
  end

  private

  def application_fee_cents
    (0.30 * amount).round
  end

  def destination
    parking.customer.account_id
  end
end
