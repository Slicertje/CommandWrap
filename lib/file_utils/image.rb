require 'RMagick'

module FileUtils

    module Image

        def self.dimensions (path)
            img = Magick::Image.read(path)[0]
            { :width => img.columns, :height => img.rows }
        end

    end
    
end