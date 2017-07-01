require 'test_helper'

class ChargeTest < ActiveSupport::TestCase
  test '#application_fee returns 26% of the cost when under 10' do
    assert_equal 2.34, Charge.application_fee(9.0)
  end

  test '#application_fee returns 24% of the cost whhen between 10 and 15' do
    assert_equal 2.64, Charge.application_fee(11.0)
  end

  test '#application_fee returns 23% of the cost when above 15' do
    assert_equal 3.68, Charge.application_fee(16.0)
  end
end
