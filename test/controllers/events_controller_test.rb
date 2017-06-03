require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:canadien)
  end

  test "should get index" do
    get events_url, headers: auth_headers, as: :json
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: {
        event: {
          end_time: @event.end_time,
          label: @event.label,
          latitude: @event.latitude,
          longitude: @event.longitude,
          price: @event.price,
          range: @event.range,
          start_time: @event.start_time
        }
      }, headers: auth_headers, as: :json
    end

    assert_response 201
  end

  test "should show event" do
    get event_url(@event), headers: auth_headers, as: :json
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: {
      event: {
        end_time: @event.end_time,
        label: @event.label,
        latitude: @event.latitude,
        longitude: @event.longitude,
        price: @event.price,
        range: @event.range,
        start_time: @event.start_time
      }
    }, headers: auth_headers, as: :json
    assert_response 200
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event), headers: auth_headers, as: :json
    end

    assert_response 204
  end
end
