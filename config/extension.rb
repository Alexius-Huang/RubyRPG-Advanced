# frozen_string_literal: true

module RubyRPG
  module Extension
    %i(attr_reader attr_writer attr_accessor).each do |attr_method|
      define_method attr_method do |*methods|
        @attribute_methods ||= []
        @attribute_methods.concat methods
        super(*methods)
      end
    end

    def top_level_classes
      ["Universe", "ApplicationController"]
    end

    def before_action(*methods)
      @before_action_methods ||= []
      @before_action_methods.concat methods
    end

    def after_action(*methods)
      @after_action_methods ||= []
      @after_action_methods.concat methods
    end

    # def method_added(name)
    # end

    def defined_methods
      instance_methods(false) - (@attribute_methods || [])
    end

    def descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end
  end
end
