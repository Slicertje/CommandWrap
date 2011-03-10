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

    def test_server_mode
        assert_nothing_raised do
            assert_equal false, CommandWrap::Config::Xvfb.server_mode
            CommandWrap::Config::Xvfb.server_mode = true
            assert_equal true, CommandWrap::Config::Xvfb.server_mode
            CommandWrap::Config::Xvfb.server_mode = false
        end
    end

    def test_server_port
        assert_nothing_raised do
            assert_equal '35', CommandWrap::Config::Xvfb.server_port
            CommandWrap::Config::Xvfb.server_port = '15'
            assert_equal '15', CommandWrap::Config::Xvfb.server_port
            CommandWrap::Config::Xvfb.server_port = '35'
        end
    end

    def test_server_command
        assert_nothing_raised do
            assert_equal 'Xvfb :35 -screen 0 1024x768x24', CommandWrap::Config::Xvfb.server_command
            CommandWrap::Config::Xvfb.server_command = 'Xvfb :15 -screen 0 1024x768x24'
            assert_equal 'Xvfb :15 -screen 0 1024x768x24', CommandWrap::Config::Xvfb.server_command
            CommandWrap::Config::Xvfb.server_command = 'Xvfb :35 -screen 0 1024x768x24'
        end
    end

    def test_stop_server_command
        assert_nothing_raised do
            assert_equal 'killall -9 Xvfb', CommandWrap::Config::Xvfb.stop_server_command
            CommandWrap::Config::Xvfb.stop_server_command = 'dummy'
            assert_equal 'dummy', CommandWrap::Config::Xvfb.stop_server_command
            CommandWrap::Config::Xvfb.stop_server_command = 'killall -9 Xvfb'
        end
    end

    def test_command_server_mode
        begin
            CommandWrap::Config::Xvfb.server_mode = true
            assert_equal 'DISPLAY=:35;ksnapshot', CommandWrap::Config::Xvfb.command('ksnapshot')
        ensure
            CommandWrap::Config::Xvfb.server_mode = false
        end
    end
        
end