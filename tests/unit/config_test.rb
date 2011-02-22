require File.dirname(__FILE__) + "/../test_helper"

class ConfigTest < Test::Unit::TestCase

    def test_exists
        assert_nothing_raised do
            CommandWrap::Config
        end
    end

    def test_tmp_dir
        tmp_dir = '/tmp'
        assert_equal tmp_dir, CommandWrap::Config.tmp_dir
        CommandWrap::Config.tmp_dir = '/home/test/tmp'
        assert_equal '/home/test/tmp', CommandWrap::Config.tmp_dir
        CommandWrap::Config.tmp_dir = tmp_dir
    end

    def test_pdftk
        pdftk = 'pdftk'
        assert_equal pdftk, CommandWrap::Config.pdftk
        assert_equal 'pdftk', CommandWrap::Config.pdftk
        CommandWrap::Config.pdftk = '/usr/bin/pdftk'
        assert_equal '/usr/bin/pdftk', CommandWrap::Config.pdftk
        CommandWrap::Config.pdftk = pdftk
    end

    def test_zip
        zip = 'zip'
        assert_equal 'zip', CommandWrap::Config.zip
        CommandWrap::Config.zip = '/usr/bin/zip'
        assert_equal '/usr/bin/zip', CommandWrap::Config.zip
        CommandWrap::Config.zip = zip
    end

end