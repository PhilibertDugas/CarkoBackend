require 'test_helper'

class CustomerNotificationJobTest < ActiveJob::TestCase
  test "#perform will send a notification when the recipient has a token" do
    NotificationPushService.expects(:send).once
    reservation = reservations(:one)
    reservation.customer.update(token: 'abc')
    CustomerNotificationJob.perform_now(reservation, 'test')
  end
end
