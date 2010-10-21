module FileUtils

    module OpenOffice

        autoload :Server,   File.dirname(__FILE__) + "/open_office/server"

        def self.convert (source, target)
            command = File.dirname(__FILE__) + "/../../bin/DocumentConverter.py"
            result = `#{FileUtils::Config::OpenOffice.python} #{command}  #{source} #{target} #{FileUtils::Config::OpenOffice.port}`
            puts "#{FileUtils::Config::OpenOffice.python} #{command} #{source} #{target}"
            puts result
            raise result unless result.strip == ''
        end

    end

end