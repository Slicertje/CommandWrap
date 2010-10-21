require File.dirname(__FILE__) + "/../test_helper"

class ConfigTest < Test::Unit::TestCase

    def test_config_exists
        assert_nothing_raised do
            FileUtils::Config
        end
    end

end