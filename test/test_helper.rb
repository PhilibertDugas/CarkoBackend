ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'
require 'stripe_mock'

class ActiveSupport::TestCase
  include ActiveJob::TestHelper

  fixtures :all

  def auth_headers
    @token ||= File.read(Rails.root.join("test", "fixtures", "token.txt"))
    { "Authorization" => "Bearer #{@token}" }
  end
end
