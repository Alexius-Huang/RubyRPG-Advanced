# frozen_string_literal: true

class Universe
  include ActiveSupport::Callbacks
  extend RubyRPG::Extension

  attr_reader :name, :type

  def initialize(name, type = 'universe')
    @name = name
    @type = type
    @test = [] unless production?
  end

  def to_hash
    h = {}
    self.class.attributes.each do |attr|
      h[attr] = self.send(attr)
    end
    h
  end

  def to_json
    JSON.dump(self.to_hash)
  end
end
