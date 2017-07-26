# frozen_string_literal: true

class Location < Universe
  class << self
    def current_location
      @current_location ||= all.query_id(1)
    end

    def instance
      new(@current_location[:name], @current_location[:monsters])
    end

    def set!(id)
      @current_location = all.query_id(id)
    end

    def all
      JSON.parse_file "#{RubyRPG::Settings::ROOT}/application/data/location.json"
    end
  end

  attr_reader :name, :monster_data, :type

  def initialize(name, monster_data, type = 'location')
    super(name, type)
    @monster_data = monster_data
  end

  def random_encounter
    pivot = rand.round(2)
    range_start = 0
    monster_id = nil
    monster_data.each do |monster_hash|
      range_end = range_start + monster_hash[:possibility]
      if (range_start...range_end).include? pivot
        monster_id = monster_hash[:id]
        break
      else
        range_start = range_end
      end
    end

    if monster_id.nil?
      { label: 'nothing_special' }
    else
      { label: 'fight_monster', monster_id: monster_id}
    end
  end
end
