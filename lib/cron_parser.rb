require './lib/cron_expression'

class CronParser
  def self.parse(input)
    new.(input)
  end

  def call(expr)
    cron_expression = CronExpression.new(expr)
    puts "minute       #{cron_expression.minute}"
    puts "hour         #{cron_expression.hour}"
    puts "day of month #{cron_expression.day_of_month}"
    puts "month        #{cron_expression.month}"
    puts "day of week  #{cron_expression.day_of_week}"
    puts "command      #{cron_expression.command}"
  rescue StandardError => e
    puts e.message
  end
end
