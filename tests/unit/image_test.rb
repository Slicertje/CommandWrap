require File.dirname(__FILE__) + '/../test_helper'

class ImageTest < Test::Unit::TestCase

    def test_image_exists
        assert_nothing_raised do
            FileUtils::Image
        end
    end

    def test_image_dimensions
        dim =  { :width => 150, :height => 200 }
                
        assert_equal dim, FileUtils::Image.dimensions(File.dirname(__FILE__) + "/../helpers/img150x200.jpg")
    end

end