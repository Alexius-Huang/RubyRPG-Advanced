# frozen_string_literal: true

module IoHelper
  def bar_string(quantity, total_quantity, color = :white)
    total_bars_slot = 50
    bars = total_quantity.zero? ? 0 : (quantity / total_quantity.to_f * total_bars_slot).to_i
    spaces = total_bars_slot - bars
    str = "[#{" " * spaces}#{"|".send(color) * bars}][#{quantity}/#{total_quantity}]"
  end
end
