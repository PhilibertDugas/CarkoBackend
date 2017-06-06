class FreeParkingJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    parking = reservation.parking
    parking.update!(is_available: true)
    reservation.update!(is_active: false)
  end
end
