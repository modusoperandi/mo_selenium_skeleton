# encoding: utf-8

require "selenium-webdriver"
require "rspec"
require 'mo_test_helpers/selenium_rspec'
include RSpec::Expectations

describe "TestFileSpec" do

  before(:each) do
    @base_url = "https://www.google.com/"
    @accept_next_alert = true
    @verification_errors = []
    
    @driver = SeleniumHelper.grid_selenium_browser

    unless @driver
      raise ArgumentError.new('Driver not found!')
    end
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
    @driver.save_screenshot("./screen.png")
  end
  
  it "test_file_spec" do
    @driver.get "https://pegasus.pressmatrix.com"
    # Warning: assertTextPresent may require manual changes
    @driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*Email[\s\S]*$/
    # Warning: assertTextPresent may require manual changes
    @driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*Password[\s\S]*$/
    @driver.find_element(:id, "user_email").clear
    @driver.find_element(:id, "user_email").send_keys "max@maxschulze.com"
    @driver.find_element(:id, "user_password").clear
    @driver.find_element(:id, "user_password").send_keys "test"
    @driver.find_element(:name, "commit").click
    # Warning: assertTextPresent may require manual changes
    @driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*Invalid email or password[\s\S]*$/
    # ERROR: Caught exception [ERROR: Unsupported command [captureEntirePageScreenshot | c:\jenkins\screen.png | ]]
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert.text
  ensure
    @accept_next_alert = true
  end
end
