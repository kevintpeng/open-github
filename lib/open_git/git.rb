module OpenGit
  module Git
    class NoGitRepoError < StandardError
    end

    class InvalidRemoteError < StandardError
    end

    class NoRemoteError < StandardError
    end

    # asserting that rest of git commands will work
    def self.is_git_repo
      # only returns true if in git repo and not in the .git folder itself
      `git rev-parse --is-inside-work-tree`.strip == "true"
    end

    def self.remote_url(remote_name)
      `git ls-remote --get-url #{remote_name}`.strip
    end

    def self.url(name = nil)
      remote_name = name || self.remote
      url = self.remote_url(remote_name)
      # git returns the remote id instead of link if it is not valid
      raise OpenGit::Git::InvalidRemoteError if url == remote_name
      url
    end

    def self.remote
      lines = `git remote`.lines
      raise OpenGit::Git::NoRemoteError if lines.size == 0
      lines[-1].strip
    end

    def self.branch
      `git rev-parse --abbrev-ref HEAD`.strip
    end
    
    def self.upstream
      up = `git rev-parse --abbrev-ref --symbolic-full-name @{u}`.strip
      # ignore output if error code 128, no upstream error
      up = '' if $CHILD_STATUS == 128
      up
    end
  end
end
