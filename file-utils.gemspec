Gem::Specification.new do |spec|
    spec.name = 'file-utils'
    spec.author = 'Stefaan Colman'
    spec.description = 'A set of utility classes to extract meta data from different file types'

    spec.files = Dir.glob("lib/*.rb") + Dir.glob("tests/*.rb") + %w(README) + Dir.glob("bin/*")
    spec.test_files = Dir.glob("tests/*.rb")

    spec.version = '0.1'

    spec.add_dependency('rmagick', '>= 2.13.1')
end