# frozen_string_literal: true

module DirectoryInitializer
  Dir.class_eval do
    class << self
      def file_counts(dir)
        Dir[dir].size
      end
    end
  end
end
