# frozen_string_liternal: true

# Extends the kernal methods which can help developing the project
module Kernal
  %w[development testing production].each do |env|
    define_method "#{env}?" do
      RubyRPG::Settings::ENV == env
    end
  end
end
