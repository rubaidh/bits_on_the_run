spec = Gem::Specification.new do |s|

  s.name              = 'bits_on_the_run'
  s.version           = '0.99.0'
  s.date              = '2009-07-16'
  s.authors           = ['Graeme Mathieson', 'Mark Connell', 'Rubaidh Ltd']
  s.email             = 'support@rubaidh.com'
  s.homepage          = 'http://github.com/rubaidh/bits_on_the_run'
  s.summary           = 'Ruby implementation of the Bits on the run API'
  s.rubyforge_project = 'rubaidh'

  s.description = "This is a Ruby implementation of the API for Bits on " + 
    "the run, a video hosting service. See <http://www.bitsontherun.com/> " + 
    "for more details."

  s.files = %w(
    bits_on_the_run.gemspec CHANGELOG MIT-LICENSE Rakefile README.rdoc
    lib/bits_on_the_run.rb
    spec/spec_helper.rb
  )

  s.has_rdoc          = true
  s.extra_rdoc_files += ['README.rdoc', 'CHANGELOG', 'MIT-LICENSE']
  s.rdoc_options     += [
    '--title', 'Bits on the run', '--main', 'README.rdoc', '--line-numbers'
  ]
end
