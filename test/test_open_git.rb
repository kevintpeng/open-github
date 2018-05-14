require "minitest/autorun"
require "open_git"

class TestOpenGit < Minitest::Test
  # unit tests
  def test_github_parse_https
    match = OpenGit::Github.parse "https://github.com/kevintpeng/open_git.git"
    assert_equal "https", match[:protocol]
    assert_equal "github.com", match[:domain]
    assert_equal "kevintpeng", match[:org]
    assert_equal "open_git", match[:repo]
  end

  def test_github_parse_http
    match = OpenGit::Github.parse "http://github.com/kevintpeng/open_git.git"
    assert_equal "http", match[:protocol]
    assert_equal "github.com", match[:domain]
    assert_equal "kevintpeng", match[:org]
    assert_equal "open_git", match[:repo]
  end


  def test_github_parse_ssh
    match = OpenGit::Github.parse "git@github.com:kevintpeng/open_git.git"
    assert_equal "ssh", match[:protocol]
    assert_equal "github.com", match[:domain]
    assert_equal "kevintpeng", match[:org]
    assert_equal "open_git", match[:repo]
  end

  def test_github_parse_invalid
    assert_raises OpenGit::Github::InvalidLinkError do
      OpenGit::Github.parse "git://github.com:kevintpeng/open-git.git"
    end
  end

  # integration tests
  def test_open_github
    OpenGit::Git.stub(:is_git_repo, true) do
      OpenGit::Git.stub(:url, "https://github.com/kevintpeng/open_git.git") do
        assert_equal "https://github.com/kevintpeng/open_git",
                     OpenGit::Open.github
      end
    end
  end

  def test_open_github_with_args
    stub = Proc.new do |arg|
      arg == "origin" ? "https://github.com/kevintpeng/open_git.git" : ""
    end
    OpenGit::Git.stub(:is_git_repo, true) do
      OpenGit::Git.stub(:url, stub) do
        assert_equal "https://github.com/kevintpeng/open_git",
                     OpenGit::Open.github("origin")
      end
    end
  end

  def test_open_github_with_invalid_args
    stub = Proc.new do |arg|
      arg == "origin" ? "https://github.com/kevintpeng/open_git.git" : arg
    end

    assert_raises OpenGit::Git::InvalidRemoteError do
      OpenGit::Git.stub(:is_git_repo, true) do
        OpenGit::Git.stub(:remote_url, stub) do
          assert_equal "https://github.com/kevintpeng/open_git",
                       OpenGit::Open.github("notorigin")
        end
      end
    end
  end

  def test_open_github_no_git_repo
    assert_raises OpenGit::Git::NoGitRepoError do
      OpenGit::Git.stub(:is_git_repo, false) do
        OpenGit::Git.stub(:url, "https://github.com/kevintpeng/open_git.git") do
          OpenGit::Open.github
        end
      end
    end
  end

  def test_open_github_pull_request
    OpenGit::Git.stub(:is_git_repo, true) do
      OpenGit::Git.stub(:url, "https://github.com/kevintpeng/open_git.git") do
        OpenGit::Git.stub(:branch, "my_branch") do
          assert_equal "https://github.com/kevintpeng/open_git/pull/my_branch",
                       OpenGit::Open.github_pull_request
        end
      end
    end
  end
end
