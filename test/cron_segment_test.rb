require 'minitest/autorun'
require './lib/cron_segment'

class CronSegmentTest < Minitest::Test
  def test_initialize
    assert_equal CronSegment.new('', nil).class, CronSegment
  end

  def test_list_segment
    assert_equal CronSegment.new('1,2,4', 1..6).result, [1, 2, 4]
  end

  def test_range_segment
    assert_equal CronSegment.new('1-4', 1..6).result, [1, 2, 3, 4]
  end

  def test_step_segment1
    assert_equal CronSegment.new('*/2', 1..6).result, [1, 3, 5]
  end

  def test_step_segment2
    assert_equal CronSegment.new('2/2', 1..6).result, [2, 4, 6]
  end

  def test_all_segment
    assert_equal CronSegment.new('*', 1..6).result, [1, 2, 3, 4, 5, 6]
  end
end

