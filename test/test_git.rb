require "minitest/autorun"
require "open_git"

class TestOpenGit < Minitest::Test
  def test_git_url
    OpenGit::Git.stub(:remote_url, "https://github.com/kevintpeng/open_git.git") do
      assert_equal "https://github.com/kevintpeng/open_git.git", OpenGit::Git.url("my_remote")
    end
  end

  def test_git_url_invalid
    assert_raises OpenGit::Git::InvalidRemoteError do
      OpenGit::Git.stub(:remote_url, "my_remote") do
        OpenGit::Git.url("my_remote")
      end
    end
  end
end
