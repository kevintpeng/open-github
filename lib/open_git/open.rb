module OpenGit
  module Open
    def self.github(remote = nil)
      raise OpenGit::Git::NoGitRepoError unless OpenGit::Git.is_git_repo
      match = OpenGit::Github.parse(OpenGit::Git.url(remote))
      protocol = match[:protocol]
      protocol = "https" if protocol == "ssh"
      "#{protocol}://#{match[:domain]}/#{match[:org]}/#{match[:repo]}"
    end

    def self.github_pull_request(remote = nil)
      "#{self.github(remote)}/pull/#{OpenGit::Git.branch}"
    end

    def self.github_new_pull_request(remote = nil)
      "#{self.github(remote)}/pull/new/#{OpenGit::Git.branch}"
    end
  end
end
