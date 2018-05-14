module OpenGit
  module Github
    class InvalidLinkError < StandardError
    end

    def self.parse(link)
      re = /^((git@)|(https?:\/\/))(.*)[\/:]([^:\/]*)\/([^:\/]*)\.git$/
      match = re.match(link)
      raise OpenGit::Github::InvalidLinkError unless match
      return {
        protocol: if match[2]
          "ssh"
        elsif match[3] == "https://"
          "https"
        elsif match[3] == "http://"
          "http"
        end,
        domain: match[4],
        org: match[5],
        repo: match[6]
      }
    end
  end
end
