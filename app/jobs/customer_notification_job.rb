class CustomerNotificationJob < ApplicationJob
  queue_as :default

  def perform(reservation, message)
    customer = reservation.customer
    if token = customer.token
      message = "Your reservation will end in 15 minutes"
      NotificationPushService.send(token, message)
    end
  end
end
