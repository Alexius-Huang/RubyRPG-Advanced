# frozen_string_literal: true

class BaseController < ApplicationController
  include ScriptHelper
  after_action :render_script, :reset_controller_params

  private

  def render_script(classname = current_class, action = current_method, transfer_label = ApplicationController.transfer_label, params = {})
    script_content = File.read "#{RubyRPG::Settings::ROOT}/application/scripts/#{classname}/#{action}.yml.erb"
    struct = {}
    instance_variables.each do |v|
      struct[v.to_s[1..-1].to_sym] = instance_variable_get(v)
    end
    params.each_pair do |k, v|
      struct[k.to_sym] = v
    end
    exec_script YAML.load(ERB.new(script_content).result(OpenStruct.new(struct).get_binding)), transfer_label
  end

  def reset_controller_params
    ApplicationController.set_params({})
  end
end
