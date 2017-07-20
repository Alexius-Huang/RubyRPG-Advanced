# frozen_string_literal: true

module StringInitializer
  String.class_eval do
    def to_underscore
      self.gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
          .gsub(/([a-z\d])([A-Z])/,'\1_\2')
          .tr("-", "_")
          .downcase
    end

    def to_camelcase
      self.split('_')
          .map(&:capitalize!)
          .join
    end
  end
end
