# frozen_string_literal: true

module JsonInitializer
  JSON.module_eval do
    class << self
      alias :old_parse :parse
      def parse(json_text)
        arr_of_hash = self.old_parse(json_text)
        arr_of_hash.map { |h| h.symbolize_keys }
      end

      def parse_file(file_path)
        self.parse File.read(file_path)
      end
    end
  end
end
