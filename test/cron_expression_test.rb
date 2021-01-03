require 'minitest/autorun'
require './lib/cron_expression'

class CronExpressionTest < Minitest::Test
  def test_initialize
    assert_equal CronExpression.new('0 0 0 0 0 /bin/sh').class, CronExpression
  end

  def test_valid
    assert CronExpression.valid?('0 0 0 0 0 /bin/sh')
  end

  def test_invalid
    refute CronExpression.valid?('/bin/sh')
  end

  def test_minute
    assert_equal CronExpression.new('0 0 0 0 0 /bin/sh').minute, '0'
  end

  def test_hour
    assert_equal CronExpression.new('0 0 0 0 0 /bin/sh').minute, '0'
  end

  def test_day_of_month
    assert_equal CronExpression.new('0 0 1 0 0 /bin/sh').day_of_month, '1'
  end

  def test_month
    assert_equal CronExpression.new('0 0 0 1 0 /bin/sh').month, '1'
  end

  def test_day_of_week
    assert_equal CronExpression.new('0 0 0 0 0 /bin/sh').day_of_week, '0'
  end

  def test_command
    assert_equal CronExpression.new('0 0 0 0 0 /bin/sh').command, '/bin/sh'
  end
end
