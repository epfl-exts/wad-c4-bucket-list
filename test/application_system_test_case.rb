# frozen_string_literal: true

require 'test_helper'
require 'support/capybara.rb'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium_chrome_in_container

  def after_setup
    super
    Capybara.server_host = "0.0.0.0"
    Capybara.server_port = 4000
    # app_host **must** be set in the around test set up because Rails overrides 
    # Capybara.app_host earlier in the test set up. If you try to set Capybara.app_host
    # earlier in the test run lifecycle, Rails will throw this setting away.
    # See: https://github.com/teamcapybara/capybara/pull/2028
    Capybara.app_host = "http://web:4000"
  end
end
