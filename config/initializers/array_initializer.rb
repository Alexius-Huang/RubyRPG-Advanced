# frozen_string_literal: true

module ArrayInitializer
  Array.class_eval do
    # method for "query_" 
    def method_missing(m, *args, &block)
      super(m, *args, &block) unless m.to_s.start_with? 'query_'
      key = m.to_s['query_'.length..-1].to_sym
      result = select { |hash| hash[key] == args[0] }
      result.length.zero? ? nil : result.first
    end
  end
end
