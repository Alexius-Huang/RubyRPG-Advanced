# frozen_string_literal: true

class Monster < Character
  class << self
    def all
      RubyRPG::MonsterData
    end

    def current_instance
      @monster
    end

    def set!(id)
      monster_data = all.query_id(id)
      @monster = new(
        id = id,
        name = monster_data[:name],
        level = monster_data[:level],
        health = monster_data[:health],
        mana = monster_data[:mana],
        strength = monster_data[:strength],
        experience = monster_data[:experience]
      )
    end

    def print_status
      monster_data = all.query_id(@monster.id)
      puts " :: #{@monster.name}"
      puts " :: HP  ".light_red + bar_string(@monster.health, monster_data[:health], :light_red)
      puts " :: MP  ".light_blue + bar_string(@monster.mana, monster_data[:mana], :light_blue)
      puts " :: Strength :: #{@monster.strength}"
    end
  end

  attr_reader :id, :name, :level, :health, :mana, :strength, :experience, :type

  def initialize(id, name, level, role = 'monster', health, mana, strength, experience)
    super(id, name, level, role, health, mana, strength, experience, type = 'monster')
  end
end
