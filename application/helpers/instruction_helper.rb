# frozen_string_literal: true

module InstructionHelper
  class << self
    def print_character_stat
"
- :send:
    :receiver: Character
    :method: print_status
- :system: new_line
"
    end

    def print_monster_stat
"
- :send:
    :receiver: Monster
    :method: print_status
- :system: new_line
"
    end
  end
end
