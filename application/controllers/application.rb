# frozen_string_literal: true

class ApplicationController
  include ActiveSupport::Callbacks
  extend RubyRPG::Extension

  class << self
    def params
      @__params__
    end

    def set_params(params = {})
      @__params__ = params
    end

    def transfer_label
      @__label__
    end

    def set_transfer_label(label = '')
      @__label__ = label
    end
  end

  private

  def current_method
    @__method__.to_sym
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

  def params
    ApplicationController.params
  end
end
