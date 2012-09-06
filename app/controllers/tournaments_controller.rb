class TournamentsController < ApplicationController
  
  def index
    @tournaments = Tournament.all
  end
    
  def new
    @tournament = Tournament.new
  end
  
  def edit
    @tournament = Tournament.find(params[:id])
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def create
    @tournament = Tournament.new(params[:tournament])

    if @tournament.save
      redirect_to tournaments_url
    else
      render :action => :new
    end
  end

end