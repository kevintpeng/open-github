module OpenGitHub
  def self.remote(name = "origin")
    return `git ls-remote --get-url #{name}`.strip
  end
 
  def self.branch
    return `git rev-parse --abbrev-ref HEAD`.strip
  end

  def self.parse(url)
    re = /^((git@)|(https?:\/\/))(.*)[\/:]([^:\/]*)\/([^:\/]*)\.git$/
    re.match(url)
  end
end
