require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "ordered_events returns the events ordered by start_time" do
    events = Event.ordered_events
    assert_equal events(:canadien), events.first
    assert_equal events(:alouette), events.last
  end
end
