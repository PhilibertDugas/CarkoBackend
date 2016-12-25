class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :parking
  has_one :vehicule

  def wait_time
    stop_hour = stop_time.split(':').first
    stop_minute = stop_time.split(':').last
    Time.now.change(hour: stop_hour, min: stop_minute)
  end

  def save_with_parking
    ActiveRecord::Base.transaction do
      save
      parking.update(is_available: false)
    end
  end

  def free_parking_later
    FreeParkingJob.set(wait_until: wait_time).perform_later(parking.id)
  end
end
