# frozen_string_literal: true

module RubyRPG
  module Callback
    def self.set!
      RubyRPG::Objects.concat(RubyRPG::Controllers).each do |klass|
        setup_callbacks klass
      end
    end

    def self.setup_callbacks(klass)
      klass.class_eval do
        before_method_stack = []
        after_method_stack  = []
        current_class = self
        until top_level_classes.include? current_class.name
          current_class.class_eval do
            before_method_stack = (@before_action_methods || []) + before_method_stack          
            after_method_stack  = (@after_action_methods  || []) + after_method_stack          
            current_class = superclass
          end
        end

        return if before_method_stack.empty? and after_method_stack.empty?
        defined_methods.each do |m|
          alias :"_alias_method_#{m}" :"#{m}"
          define_callbacks m
          define_method m do
            @__method__ = m
            run_callbacks m do
              send :"_alias_method_#{m}"
            end
          end

          unless before_method_stack.empty?
            before_method_stack.each do |before_action_method|
              set_callback m, :before, before_action_method
            end
          end

          unless after_method_stack.empty?
            after_method_stack.each do |after_action_method|
              set_callback m, :after, after_action_method
            end
          end
        end
      end
    end
  end
end
