class Customer < ApplicationRecord
  has_many :parking, dependent: :destroy
end
