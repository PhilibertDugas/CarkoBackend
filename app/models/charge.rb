class Charge
  attr_reader :amount, :customer, :currency, :parking

  def initialize(amount:, customer:, currency:, parking:)
    @amount = amount
    @customer = customer
    @currency = currency
    @parking = parking
  end

  def self.application_fee(amount)
    (0.2 * amount).round
  end

  def save
    stripe_charge = Stripe::Charge.create(
      amount: amount,
      customer: customer,
      currency: currency,
      destination: destination,
      application_fee: Charge.application_fee(amount)
    )
    stripe_charge.id
  end

  private

  def destination
    parking.customer.account_id
  end
end
