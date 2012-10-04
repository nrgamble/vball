class TeamsController < ApplicationController
  
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @h1 = @team.name
  end
  
  def new
    @team = Team.new
    @h1 = 'New Team'
    
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
  
  def edit
    @team = Team.find(params[:id])
    @h1 = 'Edit Team'
  end

  def create
    @team = Team.new(params[:team])

    if @team.save
      redirect_to @team
    else
      render :action => :new
    end
  end
  
  def update
    @team = Team.find(params[:id])

    if @team.update_attributes(params[:team])
      redirect_to @team
    else
      redirect_to edit_team_url(@team)
    end
  end
  
  def destroy
    @team = Team.find(params[:id])
    @team.destroy
   
    redirect_to @team.pool
  end

end