# frozen_string_literal: true

class ExploreController < BaseController
  before_action :set_role_of_combat

  def adventure
    @location = Location.instance
    @encounter = @location.random_encounter
  end

  def combat
    @monster = Monster.current_instance
  end

  def attack_dialogue; end

  private

  def set_role_of_combat
    @active = Object.const_get(params[:active]).current_instance   if not params.nil? and params.key?(:active)
    @passive = Object.const_get(params[:passive]).current_instance if not params.nil? and params.key?(:passive)
  end

  def encounter_monster(params)
    Monster.set! params[:monster_id]
  end

  def attack(params)
    active_role = Object.const_get(params[:active]).current_instance
    passive_role = Object.const_get(params[:passive]).current_instance
    active_role.attack(passive_role)
  end
end
