# frozen_string_literal: true

class Substance < Universe
  attr_reader :name, :type

  def initialize(name, type = 'substance')
    super(name = name, type = type)
  end
end
