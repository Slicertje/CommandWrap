require File.dirname(__FILE__) + "/../test_helper"

class ConfigXvfbTest < Test::Unit::TestCase

    def test_exists
        assert_nothing_raised do
            CommandWrap::Config::Xvfb
        end
    end

    def teardown
        CommandWrap::Config::Xvfb.executable = 'xvfb-run'
        CommandWrap::Config::Xvfb.params = '--wait=0 --server-args="-screen 0, 1024x768x24"'
    end

    def test_config_xvbf_executable
        assert_kind_of String, CommandWrap::Config::Xvfb.executable
        assert_equal 'xvfb-run', CommandWrap::Config::Xvfb.executable
        CommandWrap::Config::Xvfb.executable = '/usr/bin/xvfb-run'
        assert_equal '/usr/bin/xvfb-run', CommandWrap::Config::Xvfb.executable
    end

    def test_params
        assert_kind_of String, CommandWrap::Config::Xvfb.params
        assert_equal '--wait=0 --server-args="-screen 0, 1024x768x24"', CommandWrap::Config::Xvfb.params
        CommandWrap::Config::Xvfb.params = 'dummy'
        assert_equal 'dummy', CommandWrap::Config::Xvfb.params
    end

    def test_command
        assert_equal 'xvfb-run --wait=0 --server-args="-screen 0, 1024x768x24" echo "test"', CommandWrap::Config::Xvfb.command('echo "test"')
    end
        
end