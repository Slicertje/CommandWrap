module FileUtils

    module Config

        autoload :OpenOffice,   File.dirname(__FILE__) + "/config/open_office"
        autoload :Xvfb,         File.dirname(__FILE__) + "/config/xvfb"

    end

end