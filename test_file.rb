require "selenium-webdriver"
require "rspec"
require 'mo_test_helpers/selenium_rspec'
include RSpec::Expectations

describe "TestFile" do

  before(:each) do
    @base_url = "https://pegasus.pressmatrix.com"
    @accept_next_alert = true
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_file" do
    @driver.get(@base_url + "/")
    # Warning: assertTextPresent may require manual changes
    @driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*E-Mail[\s\S]*$/
    # Warning: assertTextPresent may require manual changes
    @driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*Passwort[\s\S]*$/
    @driver.find_element(:id, "user_email").clear
    @driver.find_element(:id, "user_email").send_keys "max@maxschulze.com"
    @driver.find_element(:id, "user_password").clear
    @driver.find_element(:id, "user_password").send_keys "test"
    @driver.find_element(:name, "commit").click
    # Warning: assertTextPresent may require manual changes
    @driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*Ungültige Anmeldedaten[\s\S]*$/
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
