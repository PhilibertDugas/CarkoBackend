require 'test_helper'

class NotifyParkingRecipientNewReservationJobTest < ActiveJob::TestCase
  test "#perform will send a notification when the recipient has a token" do
    NotificationPushService.expects(:send).once
    reservation = reservations(:one)
    reservation.parking.customer.update(token: 'abc')
    NotifyParkingRecipientNewReservationJob.perform_now(reservation)
  end
end
