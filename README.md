mo_selenium_skeleton
====================

Skeleton for running our selenese tests in the mo-grid

Install
-------

* Go to your Firefox Selenium IDE
* Top bar -> Options -> Options
* Tab: Formats
* Select "Ruby / Rspec / Web Driver"
* The arguments do not matter
* Paste the following in the header field

  require "selenium-webdriver"
  require "rspec"
  require 'mo_test_helpers/selenium_rspec'
  include RSpec::Expectations

  describe "${className}" do

    before(:each) do
      ${receiver} = Selenium::WebDriver.for :firefox
      @base_url = "${baseURL}"
      @accept_next_alert = true
      @verification_errors = []
    end

    after(:each) do
      ${receiver}.quit
      @verification_errors.should == []
    end

    it "${methodName}" do

* Click ok
* Write a test
* Select "File" -> "Export Test Case as" -> "Ruby / Rspec / Webdriver"
* Save the output to this folder into the file -> "test_file.rb"
* Run against CI!