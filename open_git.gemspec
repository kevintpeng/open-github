Gem::Specification.new do |s|
  s.name        = 'open_git'
  s.version     = '0.2.0'
  s.date        = '2020-03-20'
  s.description     = "Command line utility for opening web pages for repository management services"
  s.summary     = "Command line utility for opening a repository's remote web page on github-style repository management services and for opening pull requests using the corresponding web interface"
  s.authors     = ["Kevin Peng"]
  s.email       = 'kpeng97+rubygems@gmail.com'
  s.files       = ["lib/open_git.rb", "lib/open_git/github.rb", "lib/open_git/open.rb", "lib/open_git/git.rb"]
  s.executables << 'opr'
  s.executables << 'ogh'
  s.executables << 'push'
  s.homepage    =
    'http://rubygems.org/gems/open_git'
  s.license       = 'MIT'
end
