class Customer < ApplicationRecord
  has_many :parkings, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_one :vehicule, dependent: :destroy

  def as_json(options = {})
    super(include: [:reservations, :parkings, :vehicule])
  end

  def default_account_settings
    { managed: true }
  end
end
