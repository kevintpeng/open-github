require "minitest/autorun"
require "open_git"

class TestOpenGitGithub < Minitest::Test
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
end
