# frozen_string_literal: true

class BaseController < ApplicationController
  include ScriptHelper
  after_action :render_script

  private

  def render_script(classname = self.class.name, action = current_method)
    script_content = File.read "#{RubyRPG::Settings::ROOT}/application/scripts/#{current_class}/#{action}.yml.erb"
    struct = {}
    instance_variables.each do |v|
      struct[v.to_s[1..-1].to_sym] = instance_variable_get(v)
    end
    exec_script YAML.load(ERB.new(script_content).result(OpenStruct.new(struct).get_binding))
  end
end
