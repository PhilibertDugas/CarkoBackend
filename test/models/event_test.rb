require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "#ordered_events returns the events ordered by start_time" do
    events = Event.ordered_events
    assert events.first.start_time < events.last.start_time
  end

  test "#available_parkings returns parkings in the range of the event" do
    event = events(:alouette)
    expected_parking = parkings(:alouette_parking)
    too_far_parking = parkings(:alouette_parking_too_far)

    parkings = event.available_parkings
    assert_includes parkings, expected_parking
    assert_not_includes parkings, too_far_parking
  end
end
