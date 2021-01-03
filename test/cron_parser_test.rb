require 'minitest/autorun'
require './lib/cron_parser'

class CronParserTest <  Minitest::Test
  def setup
    @instance = CronParser.new
  end

  def test_initialize
    assert_equal @instance.class, CronParser
  end
end
