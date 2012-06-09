class GamesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @games = Game.scoped
  end

  def new
    @game = current_user.games.build
  end

  def create
    @game = current_user.games.build(params[:game])
    if @game.save
      redirect_to games_path, notice: "Game #{@game.title} has been created."
    else
      render :new
    end
  end
end
