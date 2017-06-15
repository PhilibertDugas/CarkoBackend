class RecipientNotificationJob < ApplicationJob
  queue_as :default

  def perform(reservation, message)
    recipient = reservation.parking.customer
    if token = recipient.token
      # TODO: This might need translations based on the user preference
      message = "Congratulations, you have a new reservation on #{reservation.start_time}"
      NotificationPushService.send(token, message)
    end
  end
end
