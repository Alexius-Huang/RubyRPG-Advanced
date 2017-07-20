# frozen_string_literal: true

require "#{Dir.pwd}/config/settings.rb"

# Requiring gems
RubyRPG::Settings::Gems.each_pair do |env, gems|
  next unless env.include? RubyRPG::Settings::ENV
  gems.each do |gem|
    require gem
    puts "Gem Loaded - #{gem}" if env != 'production'
  end
end

# Loading Initializers
Dir["#{RubyRPG::Settings::ROOT}/config/initializers/*.rb"].each do |f|
  require f
  filename = File.basename f, '.rb'
  module_name = filename.split('_').each(&:capitalize!).join
  eval "include #{module_name}"
  puts "Initialize - #{module_name}" if RubyRPG::Settings::ENV != 'production'
end

# Loading Helpers
Dir["#{RubyRPG::Settings::ROOT}/application/helpers/*.rb"].each do |f|
  require f
  puts "Helper loaded - #{File.basename(f, '.rb')}" if development?
end

# Kernal methods can now be used below

# Loading Files
RubyRPG::Settings::Files.each do |f|
  require "#{RubyRPG::Settings::ROOT}#{f}"
  puts "File loaded - #{f}" if development?
end

# Setting Up Callbacks
RubyRPG::Callback.set! if RubyRPG::Settings::Callback
