require "minitest/autorun"
require "open_git"

class TestOpen < Minitest::Test
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
