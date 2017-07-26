# frozen_string_literal: true

class Matrix < Universe
  extend RecordHelper

  class << self
    def save_game!(id = nil)
      write_record(id, {
        character: Character.current_instance.to_hash,
        location_id: Location.current_location[:id]
      })
    end
  end
end
