class FreeParkingJob < ApplicationJob
  queue_as :default

  def perform(parking_id)
    parking = Parking.find_by(id: parking_id)
    parking.update!(is_available: true)
  end
end
