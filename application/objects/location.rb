# frozen_string_literal: true

class Location < Universe
  attr_reader :name, :type

  def initialize(name, type = 'location')
    super(name, type)
  end
end
