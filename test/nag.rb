require "minitest/autorun"

class TestNag < Minitest::Unit::TestCase
  def setup
    @nag = 1
  end

  def test_testing
    assert 1 == 0, "test testing"
  end

  def teardown
    @nag = nil
  end
end
