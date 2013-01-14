# encoding: utf-8

require "selenium-webdriver"
require "rspec"
require 'mo_test_helpers/selenium_rspec'
include RSpec::Expectations

describe "${className}" do

  before(:each) do
    @base_url = "${baseURL}"
    @accept_next_alert = true
    @verification_errors = []
    
    @driver = SeleniumHelper.grid_selenium_browser

    unless @driver
      raise ArgumentError.new('Driver not found!')
    end
  end
  
  after(:each) do
    @driver.save_screenshot("./screen-#{Time.now.to_i.to_s}.png")
    ${receiver}.quit
    @verification_errors.should == []
  end
  
  it "${methodName}" do
