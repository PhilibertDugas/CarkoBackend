class ReservationCreator
  def self.process(reservation, charge: charge)
    return false unless reservation.valid?
    return false unless reservation&.parking&.is_available

    reservation.charge = charge.save
    application_fee = Charge.application_fee(charge.amount)
    reservation.application_fee = application_fee
    reservation.customer_revenue = reservation.total_cost - application_fee

    ActiveRecord::Base.transaction do
      reservation.parking.update!(is_available: false)
      reservation.save!
    end
    FreeParkingJob.set(wait_until: reservation.stop_time).perform_later(reservation)
    queue_notifications(reservation)

    true
  end

  private

  def self.queue_notifications(reservation)
    RecipientNotificationJob.perform_later(reservation, "Congratulations, you have a new reservation on #{reservation.start_time}")
    RecipientNotificationJob.set(wait_until: reservation.start_time - 2.hours).perform_later(reservation, "Reminder that you have a reservation starting in 2 hours")
    CustomerNotificationJob.set(wait_until: reservation.stop_time - 15.minutes).perform_later(reservation, "Your reservation will end in 15 minutes")
  end
end
