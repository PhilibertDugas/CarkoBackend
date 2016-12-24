class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :parking
  has_one :vehicule

  def wait_time
    stop_hour = stop_time.split(':').first
    stop_minute = stop_time.split(':').last
    Time.now.change(hour: stop_hour, minute: stop_minute)
  end
end
