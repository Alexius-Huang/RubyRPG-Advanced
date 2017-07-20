# frozen_string_literal: true

class Monster < Character
  attr_reader :name, :level, :health, :mana, :strength, :experience, :type

  def initialize(name, level, health, mana, strength, experience)
    super(name, level, health, mana, strength, experience, type = 'monster')
  end
end
