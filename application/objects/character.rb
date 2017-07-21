# frozen_string_literal: true

class Character < Universe
  attr_reader :name, :level, :role, :health, :mana, :strength, :experience, :type

  class << self
    def create!(params)
      @main_character = new(
        name = params[:character_name],
        level = 1,
        role = params[:character_role],
        health = 50,
        mana = 10,
        strength = 10,
        experience = 0
      )
      Matrix.save_game!
    end

    def set!(record_id)
      record = Matrix.records.query_id record_id
      @main_character = new(
        name = record[:name],
        level = record[:level],
        role = record[:role],
        health = record[:health],
        mana = record[:mana],
        strength = record[:strength],
        experience = record[:experience]
      )
    end

    def main_character
      @main_character
    end
  end

  def initialize(name, level, role, health, mana, strength, experience, type = 'character')
    super(name, type)
    @level = level
    @role = role
    @health = health
    @mana = mana
    @strength = strength
    @experience = experience
  end
end
