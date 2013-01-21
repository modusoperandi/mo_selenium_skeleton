mo_selenium_skeleton
====================

Skeleton for running our selenese tests in the mo-grid

Install the IDE
---------------

* Go to your Firefox Selenium IDE
* Top bar -> Options -> Options
* Tab: Formats
* Select "Ruby / Rspec / Web Driver"
* The arguments do not matter
* Paste the content of [examples/selenium_ide_rspec_header.rb](https://github.com/modusoperandi/mo_selenium_skeleton/blob/master/examples/selenium_ide_rspec_header.rb) in the header field
* Click ok
* Write a test
* Select "File" -> "Export Test Case as" -> "Ruby / Rspec / Webdriver"
* Save the output to this folder into the file -> "test_file.rb"
* Run against CI!

Preparing a Rails 3 App for Testing on the Grid
-----------------------------------------------

* Add to your Gemfile

        gem 'mo_test_helpers', :git => "git://github.com/modusoperandi/mo_test_helpers.git"

* Run `bundle`
* If you don't plan to use RSpec for anything else then M-O Selenium Tests
    * In your spec/spec_helper.rb, paste the code from [examples/spec_helper.rb](https://github.com/modusoperandi/mo_selenium_skeleton/blob/master/examples/spec_helper.rb)
* If you plan to use RSpec for tests as well
    * Add the following lines to your spec/spec_helper.rb

            require 'mo_test_helpers/selenium_rspec'

* Place your tests anywhere in the spec directory (recommended is in integration/)
* A simple command on the bash shows you if it works (it should open a local firefox, careful FF 18 does not work yet with Selenium!)

        bundle exec rspec spec/
