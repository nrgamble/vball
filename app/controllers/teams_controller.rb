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
    @tournament = Tournament.find(params[:tournament_id])
    @pool = Pool.find(params[:pool_id])
    @h1 = 'New Team'
  end
  
  def edit
    @team = Team.find(params[:id])
    @tournament = @team.tournament
    @pool = @team.pool
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