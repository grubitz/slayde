class GamesController < ApplicationController

  SOLUTION = (1..9).to_a

  def new
    render json: SOLUTION.shuffle
  end

  def check
    status = permitted_params[:solution] == SOLUTION ? :ok : :unprocessable_entity

    render json: {}, status: status
  end

  protected

  def permitted_params
    params.permit(solution: [])
  end
end
