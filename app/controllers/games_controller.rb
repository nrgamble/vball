class GamesController < ApplicationController
  
  def index
    @games = Game.all
  end
    
  def new
    @game = Game.new
  end
  
  def edit
    @game = Game.find(params[:id])
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(params[:game])

    if @game.save
      redirect_to games_url
    else
      render :action => :new
    end
  end

end