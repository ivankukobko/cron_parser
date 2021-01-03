require './lib/cron_segment'

class CronExpression
  CRONTAB_REGEX = /([0-9\/\*\-\,]+\s+){5}([\w\-\/\s]+)/

  attr_reader :minute_raw, :hour_raw, :day_of_month_raw, :month_raw, :day_of_week_raw, :command_raw
  attr_reader :input

  def initialize(input)
    @input = input
    arr = input.split(' ')

    raise 'Invalid expression' unless CronExpression.valid?(input)

    @minute_raw = arr.shift.strip
    @hour_raw = arr.shift.strip
    @day_of_month_raw = arr.shift.strip
    @month_raw = arr.shift.strip
    @day_of_week_raw = arr.shift.strip
    @command_raw = arr.join(' ').strip
  end

  def self.valid?(input)
    CRONTAB_REGEX.match?(input)
  end

  def minute
    CronSegment.new(@minute_raw, 0..59).result.join(', ')
  end

  def hour
    CronSegment.new(@hour_raw, 0..23).result.join(', ')
  end

  def day_of_month
    CronSegment.new(@day_of_month_raw, 1..31).result.join(', ')
  end

  def month
    CronSegment.new(@month_raw, 1..12).result.join(', ')
  end

  def day_of_week
    CronSegment.new(@day_of_week_raw, 0..6).result.join(', ')
  end

  def command
    @command_raw
  end
end
