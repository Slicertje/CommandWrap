Gem::Specification.new do |spec|
    spec.name = 'command_wrap'
    spec.author = 'Stefaan Colman'
    spec.description = 'A set of utility classes to extract meta data from different file types'
    spec.summary = 'Extracting meta data from file'

    spec.files = Dir.glob("lib/**/*.rb") + Dir.glob("tests/**/*") + %w(README) + Dir.glob("bin/*")
    spec.test_files = Dir.glob("tests/**/*.rb")

    spec.version = '0.5'
    
    spec.add_dependency('rmagick', '>= 2.13.1')
    spec.add_dependency('pdf-reader')
end
