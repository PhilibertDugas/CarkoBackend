class Charge
  attr_reader :amount, :customer, :currency, :parking

  def initialize(amount:, customer:, currency:, parking:)
    @amount = amount
    @customer = customer
    @currency = currency
    @parking = parking
  end

  def self.application_fee(amount)
    fee = case
    when amount < 10
      0.26 * amount
    when amount >= 10 && amount < 15
      0.24 * amount
    when amount >= 15
      0.23 * amount
    end
    fee.round(2)
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
    fee = case
    when amount < 1000
      0.26 * amount
    when amount >= 1000 && amount < 1500
      0.24 * amount
    when amount >= 1500
      0.23 * amount
    end
    fee.round
  end

  def destination
    parking.customer.account_id
  end
end
