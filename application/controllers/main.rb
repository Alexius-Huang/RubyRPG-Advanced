# frozen_string_literal: true

class MainController < BaseController
  def menu
    @version = 'alpha 0.0.1'
  end

  def new_game; end

  def load_game
    @records = Matrix.records
  end

  private

  def create_character(params)
    Character.create!(params)
  end

  def load_character(params)
    Character.set!(params[:load_record_id])
  end
end
