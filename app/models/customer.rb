class Customer < ApplicationRecord
  has_many :parkings, dependent: :destroy
  has_many :reservations, dependent: :destroy

  def as_json(options = {})
    super(include: [:reservations, :parkings])
  end
end
