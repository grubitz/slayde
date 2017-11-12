class GamesController < ApplicationController
  def new
    render json: Game.riddle
  end

  def check
    user_solution = permitted_params[:solution].map(&:to_i)
    status = Game.check(user_solution) ? :ok : :unprocessable_entity

    render json: {}, status: status
  end

  protected

  def permitted_params
    params.permit(solution: [])
  end
end
