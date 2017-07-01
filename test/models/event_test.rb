require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "#ordered_events returns the events ordered by end_time" do
    Timecop.freeze('2017-05-05') do
      events = Event.ordered_events
      assert events.first.start_time < events.last.start_time
    end
  end

  test "#ordered_events returns only events in the future" do
    Timecop.freeze(events(:canadien).end_time + 1) do
      future_events = Event.ordered_events
      assert_not_includes future_events, events(:canadien)
    end
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
