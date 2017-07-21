# frozen_string_literal: true

module HashInitializer
  Hash.class_eval do
    def symbolize_keys
      Hash[self.map { |k, v| [k.to_sym, (v.is_a?(Hash) ? v.symbolize_keys : v)] }]
    end
  end
end
