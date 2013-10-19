require 'test_helper'

class MetaTest < MiniTest::Unit::TestCase
  def test_app_boots_in_less_than_a_second
    bm = Benchmark.measure do
      `bin/rails runner 0`
    end

    assert bm.real < 2
  end
end
