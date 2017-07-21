# frozen_string_literal: true

class Monster < Character
  attr_reader :name, :level, :health, :mana, :strength, :experience, :type

  def initialize(name, level, role = 'monster', health, mana, strength, experience)
    super(name, level, role, health, mana, strength, experience, type = 'monster')
  end
end
