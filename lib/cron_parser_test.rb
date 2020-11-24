require 'minitest/autorun'
require './lib/cron_parser'

class CronParserTest <  Minitest::Test
  def setup
    @instance = CronParser.new
  end

  def test_initialize
    assert_equal @instance.class, CronParser
  end

  def test_main_regex_success
    assert @instance.validate_input('*/15 0 1,15 * 1-5 /usr/bin/find')
  end

  def test_main_regex_failure
    refute @instance.validate_input('bad cron input')
  end

  def test_main_regex_parsed_elements
    expr = '*/15 0 1,15 * 1-5 /usr/bin/find'
    result = @instance.parse_crontab_expression(expr)
    assert_includes result, '*/15'
    assert_includes result, '0'
    assert_includes result, '1,15'
    assert_includes result, '*'
    assert_includes result, '1-5'
    assert_includes result, '/usr/bin/find'
  end

  def test_list_regex
    assert @instance.parse_list_regex("1,15"), '1 15'
  end

  def test_repeat_regex
    assert @instance.parse_repeat_regex("*/15", (0..60)), '0 15 30 45'
  end

  def test_range_regex
    assert @instance.parse_range_regex("1-5"), '1 2 3 4 5'
  end

  def test_all_regex
    assert @instance.parse_all_regex("*", (1..12)), '1 2 3 4 5 6 7 8 9 10 11 12'
  end
end
