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

    @teams  = @tournament.standings
    @size   = @teams.size
    #@teams  = Array(1..7)
    #@size   = 8

    @bracket = Tournament.bracket_create(@size)
    @left, @right = @bracket

    @filled = Tournament.bracket_fill(@bracket, @teams)
    @tleft, @tright = @filled

    @tleft = bracket_seed(@tleft)
    @tright = bracket_seed(@tright)
  end

  def bracket_seed(bracket)
    html = ''
    if bracket[0].kind_of?(Array)
      html += bracket_seed(bracket[0])
    else
      html = render_to_string(:partial => "brackets/s#{bracket.size}", :layout => false, :locals => { :teams => bracket } )
    end

    if bracket[1].kind_of?(Array)
      html += bracket_seed(bracket[1])
    elsif ! bracket[1].nil?
      html = render_to_string(:partial => "brackets/s#{bracket.size}", :layout => false, :locals => { :teams => bracket } )
    end
    return html
  end

end