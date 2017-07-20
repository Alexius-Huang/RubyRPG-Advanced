# frozen_string_literal: true

class ApplicationController
  include ActiveSupport::Callbacks
  extend RubyRPG::Extension

  def current_method
    @__method__
  end

  def current_class
    self.class.name[0..(-"Controller".length - 1)].to_underscore
  end

  def user_input(key, value)
    @__user_input__ ||= {}
    @__user_input__[key] = value
  end

  def user_input_params
    @__user_input__ || {}
  end
end
