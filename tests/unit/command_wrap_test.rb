require File.dirname(__FILE__) + "/../test_helper"

class CommandWrapTest < Test::Unit::TestCase

    def test_capture
        assert_nothing_raised do
            path = File.dirname(__FILE__) + "/../../google.png"
            File.delete(path) if File.exists?(path)
            CommandWrap.capture('http://www.google.be', path)
            assert File.exists?(path)
        end
    end

    def test_zip
        target = File.dirname(__FILE__) + "/../../result.zip"
        source1 = File.dirname(__FILE__) + "/../helpers/2pages.pdf"
        source2 = File.dirname(__FILE__) + "/../helpers/test.odt"

        File.delete(target) if File.exists?(target)

        assert_nothing_raised do
            CommandWrap.zip(target, source1, 'doc.pdf', source2, 'doc.odt')
            assert File.exists?(target)
        end
    end

    def test_extension
        assert_equal 'exe', CommandWrap.extension('test.exe')
    end

    def test_extension_none
        assert_equal '', CommandWrap.extension('test')
    end

    def test_preview
        target = File.dirname(__FILE__) + "/../../result.png"

        assert_nothing_raised do
            source = File.dirname(__FILE__) + "/../../README"
            
            assert_nil CommandWrap.preview(source, target, 100, 100)

            # Image
            source = File.dirname(__FILE__) + "/../helpers/scale.jpg"

            File.delete(target) if File.exists?(target)

            assert CommandWrap.preview(source, target, 100, 100), 'Creation of image preview'
            assert File.exists?(target), 'File exists? preview of image'

            # Document
            source = File.dirname(__FILE__) + "/../helpers/test.odt"

            File.delete(target) if File.exists?(target)

            assert CommandWrap.preview(source, target, 100, 100), 'Creation of odt preview'
            assert File.exists?(target), 'File exists? preview of odt'
        end
    end

    def test_temppath
        assert_nothing_raised do
            path1 = CommandWrap.temp('jpg')
            assert_equal "#{CommandWrap::Config.tmp_dir}/tmp.jpg", path1

            FileUtils.touch(path1)

            path2 = CommandWrap.temp('jpg')
            assert_equal "#{CommandWrap::Config.tmp_dir}/tmp.1.jpg", path2

            File.delete(path1)
        end
    end

    def test_index
        assert_nothing_raised do
            assert_equal '', CommandWrap.index(File.dirname(__FILE__) + "/../helpers/scale.jpg")
            assert_equal 'test', CommandWrap.index(File.dirname(__FILE__) + "/../helpers/test.txt")
            assert CommandWrap.index(File.dirname(__FILE__) + "/../helpers/test.odt").include?('TEST'), 'TEST in odt'
            assert_equal 'TESTING', CommandWrap.index(File.dirname(__FILE__) + "/../helpers/test.html")
            assert_equal 'TEST.HTM', CommandWrap.index(File.dirname(__FILE__) + "/../helpers/test.htm")
        end
    end

    def test_preview_mpg
        source = File.dirname(__FILE__) + "/../helpers/test.mpg"
        target = CommandWrap.temp('png')
        File.delete(target) if File.exists?(target)
        assert_nothing_raised do
            assert_equal false, CommandWrap.preview(source, target, 160, 200)
        end
    end

end