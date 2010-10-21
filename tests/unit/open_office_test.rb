require File.dirname(__FILE__) + "/../test_helper"

class OpenOfficeTest < Test::Unit::TestCase

    def test_open_office_exists
        assert_nothing_raised do
            FileUtils::OpenOffice
        end
    end

    def test_open_office_convert
        assert_nothing_raised do
            path = '/tmp/test.pdf'
            File.delete(path) if File.exists?(path)
            FileUtils::OpenOffice.convert File.dirname(__FILE__) + "/../helpers/test.odt", path
            assert File.exists?(path), 'Pdf bestaat niet'
        end
    end

end