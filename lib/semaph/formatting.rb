module Semaph
  module Formatting
    TIME_FORMAT = "%m-%d %H:%M".freeze

    def self.time(time)
      time.strftime(TIME_FORMAT)
    end
  end
end
