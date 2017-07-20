# frozen_string_literal: true

module OpenStructInitializer
  OpenStruct.class_eval do
    def get_binding
      binding
    end
  end
end
