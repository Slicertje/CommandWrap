require File.dirname(__FILE__) + "/../test_helper"

class FileUtilsTest < Test::Unit::TestCase

    def test_file_utils_capture
        assert_nothing_raised do
            path = File.dirname(__FILE__) + "/../../google.png"
            File.delete(path) if File.exists?(path)
            FileUtils.capture('http://www.google.be', path)
            assert File.exists?(path)
        end
    end

    def test_file_utils_zip
        target = File.dirname(__FILE__) + "/../../result.zip"
        source1 = File.dirname(__FILE__) + "/../helpers/2pages.pdf"
        source2 = File.dirname(__FILE__) + "/../helpers/test.odt"

        File.delete(target) if File.exists?(target)

        assert_nothing_raised do
            FileUtils.zip(target, source1, 'doc.pdf', source2, 'doc.odt')
            assert File.exists?(target)
        end
    end

    def test_file_extension
        assert_equal 'exe', FileUtils.extension('test.exe')
    end

    def test_file_extension_none
        assert_equal '', FileUtils.extension('test')
    end

end