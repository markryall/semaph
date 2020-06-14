require "rainbow"

module Semaph
  module Formatting
    TIME_FORMAT = "%m-%d %H:%M".freeze

    def self.time(time)
      time.strftime(TIME_FORMAT)
    end

    def self.hours_minutes_seconds(total_seconds)
      seconds = total_seconds % 60
      minutes = (total_seconds / 60) % 60
      hours = total_seconds / (60 * 60)

      format("%02<hours>d:%02<minutes>d:%02<seconds>d", hours: hours, minutes: minutes, seconds: seconds)
    end

    def self.index(number)
      Rainbow(number.to_s.rjust(2)).yellow
    end
  end
end
