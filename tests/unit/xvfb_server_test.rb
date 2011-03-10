require File.dirname(__FILE__) + "/../test_helper"

class XvfbServerTest < Test::Unit::TestCase

    def test_exists
        assert_nothing_raised do
            CommandWrap::Xvfb::Server
        end
    end

end