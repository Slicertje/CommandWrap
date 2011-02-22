require 'RMagick'

module CommandWrap
        
    # Creates a screenshot from the given url
    # Uses CutyCapt (cutycapt.sourceforge.net)
    def self.capture (url, target)
        command = CommandWrap::Config::Xvfb.command(File.dirname(__FILE__) + "/../bin/CutyCapt --min-width=1024 --min-height=768 --url=#{url} --out=#{target}")
        `#{command}`
    end

    def self.htmltopdf (source, target)
        command = CommandWrap::Config::Xvfb.command(File.dirname(__FILE__) + "/../bin/wkhtmltopdf --print-media-type #{source} #{target}")
        puts command
        `#{command}`
    end

    # Sources consists of paths followed by the filename that must be used in the zip 
    def self.zip (target, *sources)
        targetdir = "#{CommandWrap::Config.tmp_dir}/zip"
        id = 1
        while File.exists?(targetdir)
            targetdir = "#{CommandWrap::Config.tmp_dir}/zip#{id}"
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

        `#{CommandWrap::Config.zip} -j #{target} #{targetdir}/*`

        FileUtils.rm_rf(targetdir)
    end

    def self.extension (filename)
        return '' unless filename.include?('.')
        filename.split('.').last
    end

    def self.preview (source, target, width, height)
        extension = self.extension(source).upcase

        # Image ?
        formats = Magick.formats
        if formats.key?(extension) && formats[extension].include?('r')
            begin
                CommandWrap::Image.scale(source, target, width, height)
                return true
            rescue
                return false
            end
        end

        tmppdf = self.temp('pdf')
        tmppng = self.temp('png')
        begin
            # Create a pdf of the document
            CommandWrap::OpenOffice.convert(source, tmppdf)
            # Create a screenshot of first page of the generated pdf
            CommandWrap::Pdf.preview(tmppdf, tmppng)
            # Scale it down to thumb
            CommandWrap::Image.scale(tmppng, target, width, height)
            return true
        rescue

        ensure
            # Cleanup
            File.delete(tmppdf) if File.exists?(tmppdf) && File.writable?(tmppdf)
            File.delete(tmppng) if File.exists?(tmppng) && File.writable?(tmppng)
        end

        nil
    end

    # Generates a temp filepath for the given extension
    def self.temp (extension)
        path = "#{CommandWrap::Config.tmp_dir}/tmp.#{extension}"
        id = 1
        while File.exists?(path)
            path = "#{CommandWrap::Config.tmp_dir}/tmp.#{id}.#{extension}"
            id += 1
        end

        path
    end

    # Tries to convert content of file to plaintext or html
    def self.index (path)
        extension = CommandWrap.extension(path).downcase

        if extension == 'txt'
            return IO.read(path)
        end

        if extension == 'html' || extension == 'htm'
            return IO.read(path)
        end

        tmp = self.temp('html')
        begin
            CommandWrap::OpenOffice.convert(path, tmp)
            return IO.read(tmp) if File.exists?(tmp)
        rescue
        ensure
            File.delete(tmp) if File.exists?(tmp) && File.writable?(tmp)
        end

        ''
    end

    autoload :Image,        File.dirname(__FILE__) + "/command_wrap/image"
    autoload :OpenOffice,   File.dirname(__FILE__) + "/command_wrap/open_office"
    autoload :Config,       File.dirname(__FILE__) + "/command_wrap/config"
    autoload :Pdf,          File.dirname(__FILE__) + "/command_wrap/pdf"

end