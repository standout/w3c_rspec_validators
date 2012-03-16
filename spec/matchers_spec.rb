require "w3c_rspec_validators"
include W3CValidators

module RSpec
  module Matchers
    def fail
      raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    def fail_with(message)
      raise_error(RSpec::Expectations::ExpectationNotMetError, message)
    end

    def fail_matching(regex)
      raise_error(RSpec::Expectations::ExpectationNotMetError, regex)
    end
  end
end



describe "be_valid_html" do
  it "should be valid" do
    "<!DOCTYPE HTML SYSTEM>
      <html>
        <head>
          <title>dd</title>
        </head>
        <body>
        </body>
      </html>".should be_valid_html
  end

  it "should not be valid" do
    "<!DOCTYPE HTML SYSTEM>
      <html>
        <head>
          <titled>dd</title>
        </head>
        <body></body>
      </html>".should_not be_valid_html
  end

  it "should complain about an missing src attribute" do
    lambda {
      "<!DOCTYPE HTML SYSTEM>
      <html>
        <head>
          <title>dd</title>
        </head>
        <body>
          <img />
        </body>
      </html>".should be_valid_html
    }.should fail_matching(/line 7: required attribute "SRC" not specified.*<img \/>/m)
  end

  it "should use a custom uri if provided" do
    W3cRspecValidators::HTML5Validator.validator_uri = "http://blubb.de"
    validator = MarkupValidator.new
    MarkupValidator.should_receive(:new).with(:validator_uri => "http://blubb.de").and_return validator

    "dummy".should_not be_valid_html
  end
end