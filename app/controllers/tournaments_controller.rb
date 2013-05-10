class TournamentsController < ApplicationController
  
  def index
    @tournaments = Tournament.all
  end
    
  def new
    @tournament = Tournament.new
    @tournament.date = DateTime.now
    
    @h1 = 'New Tournament'
  end
  
  def edit
    @tournament = Tournament.find(params[:id])
    @h1 = 'Edit Tournament'
  end

  def show
    @tournament = Tournament.find(params[:id])
    @h1 = @tournament.name
  end

  def create
    @tournament = Tournament.new(params[:tournament])

    if @tournament.save
      redirect_to @tournament
    else
      render :action => :new
    end
  end
  
  def update
    @tournament = Tournament.find(params[:id])

    if @tournament.update_attributes(params[:tournament])
      redirect_to @tournament
    else
      redirect_to edit_tournament_url(@tournament)
    end
  end
  
  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
   
    redirect_to tournaments_url
  end

  def bracket
    @tournament = Tournament.find(params[:id])
    @h1 = @tournament.name

    @format = 0
    @teams  = @tournament.standings
    @size   = 4 #@teams.size

    @format = Tournament.bracket_create(@size)
  end

end