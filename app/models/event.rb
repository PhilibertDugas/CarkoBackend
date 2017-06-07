class Event < ApplicationRecord
  def self.ordered_events
    Event.all.sort_by(&:start_time)
  end
end
