require 'test_helper'

class RecipientNotificationJobTest < ActiveJob::TestCase
  test "#perform will send a notification when the recipient has a token" do
    NotificationPushService.expects(:send).once
    reservation = reservations(:one)
    reservation.parking.customer.update(token: 'abc')
    RecipientNotificationJob.perform_now(reservation, 'test')
  end
end
