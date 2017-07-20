# frozen_string_literal: true

module ObjectInitializer
  Object.class_eval do
    class << self
      def controller_const_get(controller_name)
        const_get("#{controller_name}_controller".to_camelcase)
      end 
    end
  end
end
