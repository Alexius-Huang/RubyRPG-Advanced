# frozen_string_literal: true

module RubyRPG
  Objects = Dir["#{Dir.pwd}/application/objects/*.rb"].map do |f|
    Object.const_get File.basename(f, '.rb').capitalize
  end
  
  Controllers = Dir["#{Dir.pwd}/application/controllers/*.rb"].map do |f|
    Object.const_get "#{File.basename(f, '.rb').capitalize}Controller"
  end
end
