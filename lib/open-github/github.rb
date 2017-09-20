module OpenGitHub
  def self.url(name = nil)
    remote_name = name || self.remote
    return `git ls-remote --get-url #{remote_name}`.strip
  end
 
  def self.branch
    return `git rev-parse --abbrev-ref HEAD`.strip
  end

  def self.parse(link)
    re = /^((git@)|(https?:\/\/))(.*)[\/:]([^:\/]*)\/([^:\/]*)\.git$/
    match = re.match(link)
    return { 
      protocol: match[2] || match[3],
      domain: match[4],
      org: match[5],
      repo: match[6]
    }
  end

  def self.remote
    lines = `git remote`.lines
    lines[-1].strip
  end
end
