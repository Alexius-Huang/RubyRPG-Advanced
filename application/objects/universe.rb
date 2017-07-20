# frozen_string_literal: true

class Universe
  include ActiveSupport::Callbacks
  extend RubyRPG::Extension
  # class << self
  #   %i(attr_reader attr_writer attr_accessor).each do |attr_method|
  #     define_method attr_method do |*methods|
  #       @attribute_methods ||= []
  #       @attribute_methods.concat methods
  #       super(*methods)
  #     end
  #   end

  #   def before_action(*methods)
  #     @before_action_methods ||= []
  #     @before_action_methods.concat methods
  #   end

  #   def after_action(*methods)
  #     @after_action_methods ||= []
  #     @after_action_methods.concat methods
  #   end

  #   # def method_added(name)
  #   # end

  #   def defined_methods
  #     instance_methods(false) - @attribute_methods
  #   end
  # end

  attr_reader :name, :type

  def initialize(name, type = 'universe')
    @name = name
    @type = type
    @test = [] unless production?
  end
end
