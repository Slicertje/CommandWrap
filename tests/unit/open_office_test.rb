require File.dirname(__FILE__) + "/../test_helper"

class OpenOfficeTest < Test::Unit::TestCase

    def test_exists
        assert_nothing_raised do
            CommandWrap::OpenOffice
        end
    end

    def test_convert
        assert_nothing_raised do
            path = CommandWrap.temp('pdf')
            CommandWrap::OpenOffice.convert File.dirname(__FILE__) + "/../helpers/test.odt", path
            assert File.exists?(path), 'Pdf bestaat niet'
            File.delete(path) if File.writable?(path)
        end
    end

    def test_convert_stream
        assert_nothing_raised do
            content = IO.read(File.dirname(__FILE__) + "/../helpers/test.odt")
            assert_kind_of String, CommandWrap::OpenOffice.convert(content, 'odt', 'pdf') 
        end
    end

end