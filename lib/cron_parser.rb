class CronParser
  CRONTAB_REGEX = /([0-9\/\*\-\,]+\s+)([0-9\/\*\-\,]+\s+)([0-9\/\*\-\,]+\s+)([0-9\/\*\-\,]+\s+)([0-9\/\*\-\,]+\s+)([0-9\w\s\/\*\-\,]+)/
  LIST_REGEX = /(\d+\,)+(\d+)/
  RANGE_REGEX = /(\d+)\-(\d+)/
  REPEAT_REGEX = /\*\/(\d+)/
  ALL_REGEX = /(\*)/


  def self.parse(input)
    new.(input)
  end

  def call(expr)
    raise 'Wrong input' unless validate_input(expr)

    minute, hour, day, month, weekday, command = parse_crontab_expression(expr)

    puts "minute       #{parse_time(minute)}"
    puts "hour         #{parse_time(hour)}"
    puts "day of month #{parse_day(day)}"
    puts "month        #{parse_month(month)}"
    puts "day of week  #{parse_weekday(weekday)}"
    puts "command      #{command}"
  rescue StandardError => e
    puts e.message
    #puts e.bactkrace
  end

  def validate_input input
    CRONTAB_REGEX.match?(input)
  end

  def parse_crontab_expression expr
    matches = CRONTAB_REGEX.match(expr).captures
    matches.map{|m| m.strip }
  end

  def parse_time value
    # allowed range for time values in cron is 0..59
    parse_list_regex(value) ||
      parse_range_regex(value) ||
      parse_repeat_regex(value, (0..59)) ||
      parse_all_regex(value, (0..59)) ||
      value
  end

  def parse_day value
    # allowed range for day of months values in cron is 1..31
    parse_list_regex(value) ||
      parse_range_regex(value) ||
      parse_repeat_regex(value, (0..31)) ||
      parse_all_regex(value, (0..31)) ||
      value
  end

  def parse_month value
    # allowed range for month values in cron is 1..12
    parse_list_regex(value) ||
      parse_range_regex(value) ||
      parse_repeat_regex(value, (1..12)) ||
      parse_all_regex(value, (1..12)) ||
      value
  end

  def parse_weekday value
    # allowed range for week day values in cron is 0..6
    parse_list_regex(value) ||
      parse_range_regex(value) ||
      parse_repeat_regex(value, (0..6)) ||
      parse_all_regex(value, (0..6)) ||
      value
  end

  def parse_list_regex(value)
    return false unless LIST_REGEX.match?(value)

    value.gsub(',', ' ')
  end

  def parse_range_regex(value)
    return false unless RANGE_REGEX.match?(value)
    ms = RANGE_REGEX.match(value).captures
    out = []
    (ms.first..ms.last).each{|t| out << t}
    out.join(' ')
  end

  def parse_repeat_regex value, allowed_range = (0..6)
    return false unless REPEAT_REGEX.match?(value)
    m = REPEAT_REGEX.match(value)[1]
    out = []
    allowed_range.each{|t| out << t if t % m.to_i == 0}
    out.join(' ')
  end

  def parse_all_regex(value, allowed_range = (0..6))
    return false unless ALL_REGEX.match?(value)
    out = []
    allowed_range.each{|t| out << t }
    return out.join(' ')
  end

  def parse_value value
    value
  end
end
