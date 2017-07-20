# frozen_string_literal: true

class Item < Substance
  def initialize(name, type = 'item')
    super(name, type)
  end
end
