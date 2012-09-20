class GamesController < ApplicationController
  
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end
  
  def new
    @game = Game.new
    
    if params[:tournament_id]
      @tournament = Tournament.find(params[:tournament_id])
    end
    
    if params[:pool_id]
      @pool  = Pool.find(params[:pool_id])
      @teams = @pool.teams
    else
      @teams = Team.all
    end
  end

  def create
    @game = Game.new(params[:game])

    if @game.save
      redirect_to @game.pool
    else
      render :action => :new
    end
  end
  
  def edit
    @game = Game.find(params[:id])
  end
  
  def update
    @game = Game.find(params[:id])

    if @game.update_attributes(params[:game])
      redirect_to @game.pool
    else
      redirect_to edit_game_url(@game)
    end
  end
  
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
   
    redirect_to @game.pool
  end

end