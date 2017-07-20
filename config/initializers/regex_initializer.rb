# frozen_string_literal: true

module RegexInitializer
  class Regex
    class << self
      def match_digits?(str)
        /^[0-9+]$/.match? str
      end
    end
  end
end
