class TeamsController < ApplicationController
  
  def index
    @teams = Team.all
  end
    
  def new
    @team = Team.new
  end
  
  def edit
    @team = Team.find(params[:id])
  end

  def show
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(params[:team])

    if @team.save
      redirect_to teams_url
    else
      render :action => :new
    end
  end

end