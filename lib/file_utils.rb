module FileUtils
        
    # Creates a screenshot from the given url
    # Uses CutyCapt (cutycapt.sourceforge.net)
    def capture (url, target)
        command = FileUtils::Config::Xvfb.command(File.dirname(__FILE__) + "/../bin/CutyCapt --url=#{url} --out=#{target}")
        `#{command}`
    end

    module_function :capture

    # Sources consists of paths followed by the filename that must be used in the zip 
    def zip (target, *sources)
        targetdir = "#{FileUtils::Config.tmp_dir}/zip"
        id = 1
        while File.exists?(targetdir)
            targetdir = "#{FileUtils::Config.tmp_dir}/zip#{id}"
            id += 1
        end
        FileUtils.mkdir(targetdir)

        path = ''
        sources.each do |value|
            if path == ''
                path = value
            else
                FileUtils.copy(path, "#{targetdir}/#{value}")
                path = ''
            end
        end

        `#{FileUtils::Config.zip} -j #{target} #{targetdir}/*`

        FileUtils.rm_rf(targetdir)
    end

    module_function :zip

    def extension (filename)
        return '' unless filename.include?('.')
        filename.split('.').last
    end

    module_function :extension

    autoload :Image,        File.dirname(__FILE__) + "/file_utils/image"
    autoload :OpenOffice,   File.dirname(__FILE__) + "/file_utils/open_office"
    autoload :Config,       File.dirname(__FILE__) + "/file_utils/config"
    autoload :Pdf,          File.dirname(__FILE__) + "/file_utils/open_office/pdf"

end