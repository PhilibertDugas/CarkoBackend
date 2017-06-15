class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :parking
  belongs_to :event
  has_one :vehicule

  def as_json(options = {})
    super(include: [:parking, :event])
  end

  def create_charge(charge_params, parking_id:)
    raise StandardError.new errors.messages unless valid?

    parking = Parking.find_by(id: parking_id)
    charge = Charge.new(
      charge_params[:amount],
      customer: charge_params[:customer],
      currency: charge_params[:currency],
      parking: parking
    )
    self.charge = charge.save
  end

  def reserve_with_parking
    ActiveRecord::Base.transaction do
      parking.update(is_available: false)
      save
    end
    FreeParkingJob.set(wait_until: stop_time).perform_later(self)
  end

  private

  def queue_notifications
    RecipientNotificationJob.perform_later(self, "Congratulations, you have a new reservation on #{reservation.start_time}")
    RecipientNotificationJob.set(wait_until: start_time - 2.hours).perform_later(self, "Reminder that you have a reservation starting in 2 hours")
    CustomerNotificationJob.set(wait_until: stop_time - 15.minutes).perform_later(self, "Your reservation will end in 15 minutes")
  end
end
