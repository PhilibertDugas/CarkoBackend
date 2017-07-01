require 'test_helper'

class ChargeTest < ActiveSupport::TestCase
  test '#application_fee returns 30% of the cost' do
    assert_equal 2.7, Charge.application_fee(9.0)
  end
end
