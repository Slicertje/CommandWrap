require File.dirname(__FILE__) + "/../test_helper"

class ConfigOpenOfficeTest < Test::Unit::TestCase

    def test_exists
        assert_nothing_raised do
            CommandWrap::Config::OpenOffice
        end
    end

    def setup
        @params = {
            :executable => CommandWrap::Config::OpenOffice.executable,
            :host       => CommandWrap::Config::OpenOffice.host,
            :port       => CommandWrap::Config::OpenOffice.port,
            :params     => CommandWrap::Config::OpenOffice.params,
            :xvfb       => CommandWrap::Config::OpenOffice.xvfb,
            :stop_xvfb  => CommandWrap::Config::OpenOffice.stop_xvfb,
            :stop       => CommandWrap::Config::OpenOffice.stop,
            :python     => CommandWrap::Config::OpenOffice.python
        }
    end

    # Reset of config
    def teardown
        CommandWrap::Config::OpenOffice.executable = @params[:executable] 
        CommandWrap::Config::OpenOffice.host       = @params[:host]
        CommandWrap::Config::OpenOffice.port       = @params[:port]
        CommandWrap::Config::OpenOffice.params     = @params[:params]
        CommandWrap::Config::OpenOffice.xvfb       = @params[:xvfb]
        CommandWrap::Config::OpenOffice.stop_xvfb  = @params[:stop_xvfb]
        CommandWrap::Config::OpenOffice.stop       = @params[:stop]
        CommandWrap::Config::OpenOffice.python     = @params[:python]
    end

    def test_config_openoffice_executable
        assert_kind_of String, CommandWrap::Config::OpenOffice.executable
        assert_equal 'soffice', CommandWrap::Config::OpenOffice.executable
        CommandWrap::Config::OpenOffice.executable = 'soffice.exe'
        assert_equal 'soffice.exe', CommandWrap::Config::OpenOffice.executable
        CommandWrap::Config::OpenOffice.executable = 'soffice'
    end

    def test_config_openoffice_port
        assert_kind_of Integer, CommandWrap::Config::OpenOffice.port
        assert_equal 8000, CommandWrap::Config::OpenOffice.port
        CommandWrap::Config::OpenOffice.port = 8020
        assert_equal 8020, CommandWrap::Config::OpenOffice.port
        CommandWrap::Config::OpenOffice.port = 8000
    end

    def test_config_openoffice_host
        assert_kind_of String, CommandWrap::Config::OpenOffice.host
        assert_equal '127.0.0.1', CommandWrap::Config::OpenOffice.host
        CommandWrap::Config::OpenOffice.host = 'localhost'
        assert_equal 'localhost', CommandWrap::Config::OpenOffice.host
        CommandWrap::Config::OpenOffice.host = '127.0.0.1'
    end

    def test_config_openoffice_params
        assert_kind_of String, CommandWrap::Config::OpenOffice.params
        assert_equal '-headless -display :30 -accept="socket,host=[host],port=[port];urp;" -nofirststartwizard', CommandWrap::Config::OpenOffice.params
        CommandWrap::Config::OpenOffice.params = '-headless -accept="socket,host=127.0.0.1,port=8100;urp;" -nofirststartwizard'
        assert_equal '-headless -accept="socket,host=127.0.0.1,port=8100;urp;" -nofirststartwizard', CommandWrap::Config::OpenOffice.params
        CommandWrap::Config::OpenOffice.params = '-headless -accept="socket,host=[host],port=[port];urp;" -nofirststartwizard'
    end

    def test_config_openoffice_command
        assert_kind_of String, CommandWrap::Config::OpenOffice.command
        assert_equal 'soffice -headless -display :30 -accept="socket,host=127.0.0.1,port=8000;urp;" -nofirststartwizard', CommandWrap::Config::OpenOffice.command

        CommandWrap::Config::OpenOffice.executable  = 'soffice.exe'
        CommandWrap::Config::OpenOffice.host = 'localhost'
        CommandWrap::Config::OpenOffice.port = 8080
        CommandWrap::Config::OpenOffice.params = '-headless -display :30 -accept="socket,host=[host],port=[port];urp;"'

        assert_equal 'soffice.exe -headless -display :30 -accept="socket,host=localhost,port=8080;urp;"', CommandWrap::Config::OpenOffice.command
    end

    def test_config_openoffice_xvfb
        assert_kind_of String, CommandWrap::Config::OpenOffice.xvfb
        assert_equal 'Xvfb :30 -screen 0 1024x768x24', CommandWrap::Config::OpenOffice.xvfb
        CommandWrap::Config::OpenOffice.xvfb = 'Xvfb'
        assert_equal 'Xvfb', CommandWrap::Config::OpenOffice.xvfb
    end

    def test_config_openoffice_stop_xvfb
        assert_kind_of String, CommandWrap::Config::OpenOffice.stop_xvfb
        assert_equal 'killall -9 Xvfb', CommandWrap::Config::OpenOffice.stop_xvfb
        CommandWrap::Config::OpenOffice.stop_xvfb = 'echo "dummy"'
        assert_equal 'echo "dummy"', CommandWrap::Config::OpenOffice.stop_xvfb
    end

    def test_config_openoffice_stop
        assert_kind_of String, CommandWrap::Config::OpenOffice.stop
        assert_equal 'killall -9 soffice.bin', CommandWrap::Config::OpenOffice.stop
        CommandWrap::Config::OpenOffice.stop = 'echo "dummy"'
        assert_equal 'echo "dummy"', CommandWrap::Config::OpenOffice.stop
    end

    def test_config_openoffice_python
        assert_kind_of String, CommandWrap::Config::OpenOffice.python
        assert_equal 'python', CommandWrap::Config::OpenOffice.python
        CommandWrap::Config::OpenOffice.python = '/usr/bin/python'
        assert_equal '/usr/bin/python', CommandWrap::Config::OpenOffice.python 
    end

end