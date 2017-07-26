# frozen_string_literal: true

class Character < Universe
  attr_reader :id, :name, :level, :role, :health, :mana, :strength, :experience, :type

  class << self
    include IoHelper
    def create!(params)
      @main_character = new(
        id = params[:id],
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
      record = Matrix.records.query_id(record_id)
      character_record = record[:character]
      @main_character = new(
        id = character_record[:id],
        name = character_record[:name],
        level = character_record[:level],
        role = character_record[:role],
        health = character_record[:health],
        mana = character_record[:mana],
        strength = character_record[:strength],
        experience = character_record[:experience]
      )
      Location.set! record[:location_id]
    end

    def current_instance
      @main_character
    end

    def print_status
      level_data = RubyRPG::LevelData.query_level(@main_character.level)
      puts " :: #{@main_character.name}'s Status"
      puts " :: HP  ".light_red + bar_string(@main_character.health, level_data[:health], :light_red)
      puts " :: MP  ".light_blue + bar_string(@main_character.mana, level_data[:mana], :light_blue)
      puts " :: EXP ".light_green + bar_string(@main_character.experience, level_data[:required_experience], :light_green)
      puts " :: Strength :: #{@main_character.strength}"
    end
  end

  def initialize(id, name, level, role, health, mana, strength, experience, type = 'character')
    super(name, type)
    @id = id
    @level = level
    @role = role
    @health = health
    @mana = mana
    @strength = strength
    @experience = experience
  end

  def attack(instance)
    @injury = rand(((self.strength * 0.6).to_i)..(self.strength))
    instance.injured(@injury)
  end

  def dead?
    @health.zero?
  end

  def caused_injury
    @injury
  end

  def injured(point)
    @health -= point
    @health = 0 unless @health > 0
  end

  def gain_experience(experience)
    @experience += experience
  end
end
