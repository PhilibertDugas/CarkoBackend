require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "ordered_events returns the events ordered by start_time" do
    events = Event.ordered_events
    assert events.first.start_time < events.last.start_time
  end
end
