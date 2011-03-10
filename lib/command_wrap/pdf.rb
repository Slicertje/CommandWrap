require 'RMagick'
require 'pdf-reader'

module CommandWrap

    module Pdf

        def self.metas (path)
            receiver = MetaDataReceiver.new
            PDF::Reader.file(path, receiver, :pages => false, :metadata => true)
            receiver.regular
        end

        def self.pages (path)
            receiver = PagesReceiver.new
            PDF::Reader.file(path, receiver, {:metadata => true, :pages => false})
            receiver.pages
        end

        # Generates an image of a pdf page
        # Page starts with 0
        def self.preview (source, target, page = 0)
            pdf = Magick::ImageList.new(source)[page]
            pdf.write target
        end

        # Merges the given pdfs into a single pdf
        def self.merge (target, *sources)
            `#{CommandWrap::Config.pdftk} #{sources.join(' ')} cat output #{target}`
        end

        class PagesReceiver

            attr_accessor :pages

            def page_count (pages)
                @pages = pages
            end
        end

        class MetaDataReceiver
            attr_accessor :regular

            def metadata (data)
                @regular = data
            end
        end

    end

end