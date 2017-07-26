# frozen_string_literal: true

module RubyRPG
  root = RubyRPG::Settings::ROOT
  Objects = Dir["#{root}/application/objects/*.rb"].map do |f|
    Object.const_get File.basename(f, '.rb').capitalize
  end
  
  Controllers = Dir["#{root}/application/controllers/*.rb"].map do |f|
    Object.const_get "#{File.basename(f, '.rb').capitalize}Controller"
  end

  MonsterData = JSON.parse_file "#{root}/application/data/monster.json"
  LevelData = JSON.parse_file "#{root}/application/data/level.json"
end
