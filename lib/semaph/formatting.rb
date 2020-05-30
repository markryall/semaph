module Semaph
  module Formatting
    TIME_FORMAT = "%Y-%m-%d %H:%M:%S".freeze

    def self.time(time)
      time.strftime(TIME_FORMAT)
    end
  end
end
