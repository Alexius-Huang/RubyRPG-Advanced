# frozen_string_literal: true

class Character < Universe
  attr_reader :name, :level, :health, :mana, :strength, :experience, :type

  def initialize(name, level, health, mana, strength, experience, type = 'character')
    super(name = name, type = type)
    @level = level
    @health = health
    @mana = mana
    @strength = strength
    @experience = experience
  end
end
