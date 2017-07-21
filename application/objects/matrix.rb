# frozen_string_literal: true

class Matrix < Universe
  extend RecordHelper

  class << self
    def save_game!(id = nil)
      write_record(id, {
        character: Character.main_character.to_hash,
        location_id: Location.current_location[:id]
      })
    end

    # def records
      
    #   # Dir["#{RubyRPG::Settings::ROOT}/application/records/*.json"].map do |path|
    #   #   id = File.basename(path, '.json')[('record_'.length)..-1].to_i
    #   #   h = JSON.parse_file(path)
    #   #   h[:id] = id
    #   #   h
    #   # end
    # end
  end
end
