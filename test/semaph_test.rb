require "test_helper"

class SemaphTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Semaph::VERSION
  end
end
