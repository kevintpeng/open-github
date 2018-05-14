Gem::Specification.new do |s|
  s.name        = 'open_git'
  s.version     = '0.0.1'
  s.date        = '2018-05-14'
  s.description     = "Command line utility for opening web pages for repository management services"
  s.summary     = "Command line utility for opening a repository's remote web page on github-style repository management services and for opening pull requests using the corresponding web interface"
  s.authors     = ["Kevin Peng"]
  s.email       = 'kevin@kpeng.ca'
  s.files       = ["lib/open_git.rb", "lib/open_git/github.rb", "lib/open_git/open.rb", "lib/open_git/git.rb"]
  s.executables << 'opr'
  s.executables << 'ogh'
  s.homepage    =
    'http://rubygems.org/gems/open_git'
  s.license       = 'MIT'
end
