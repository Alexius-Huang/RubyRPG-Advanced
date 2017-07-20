# frozen_string_literal: true

class MainController < BaseController
  def menu
    @version = 'alpha 0.0.1' 
  end

  def new_game
  end

  private

  def create_character(params)
  end
end
