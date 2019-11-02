require 'active_support'
require 'date'
require 'pry'
require 'active_support/core_ext'


class RecurringMoment
  attr_accessor :start, :interval, :period

  def initialize(start:, interval:, period:)
    @start = start
    @interval = interval
    @period = period
  end

  def match(date)
    current = @start
    day = @start.day

    while current <= date
      if current == date
        return true
      end

      if @period == 'monthly'
        current = current.advance(months: @interval)
        if (DateTime.parse("#{day}-#{current.month}-#{current.year}") rescue nil)
          current = DateTime.parse("#{day}-#{current.month}-#{current.year}")
        elsif (day == 31)
          last_day = Time.days_in_month(current.month, current.year)
          current = DateTime.parse("#{last_day}-#{current.month}-#{current.year}")
        end
      elsif @period == 'weekly'
        current = current.advance(weeks: @interval)
      elsif @period == 'daily'
        current = current.advance(days: @interval)
      end
    end
    return false
  end

end

# start = DateTime.parse('Dec 31, 2018')
# date = start.advance(months: 4)
#
# rob = RecurringMoment.new(start: start, interval: 2, period: 'monthly')
# puts rob
# puts rob.start
#
# puts rob.match(date)
