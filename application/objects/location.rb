# frozen_string_literal: true

class Location < Universe
  class << self
    def current_location
      @current_location ||= all.query_id(1)
    end

    def all
      JSON.parse_file "#{RubyRPG::Settings::ROOT}/application/data/location.json"
    end
  end

  attr_reader :name, :type

  def initialize(name, type = 'location')
    super(name, type)
  end
end
