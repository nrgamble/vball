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
      Bracket.new({ :tournament_id => @tournament.id }).save # TODO: do this with model association create
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
    @bracket    = @tournament.bracket
    @teams      = @tournament.standings

    # temp clear out games until i get this all working
    @bracket.games.each do |g|
      g.destroy
    end

    @rounds = []
    (1..@bracket.num_rounds).each do |r|
      #@rounds << r
      #@rounds << @bracket.round(r)
      @rounds << bracket_render(@bracket.round(r))
    end

    @h1 = @tournament.name
  end

  def bracket_render(bracket)
    html = ''

    if bracket[0].kind_of?(Array)
      html += bracket_render(bracket[0])
    else
      html  = render_to_string(:partial => 'brackets/s2', :locals => { :game => bracket[0] } )
      html += render_to_string(:partial => 'brackets/s2', :locals => { :game => bracket[1] } ) if ! bracket[1].nil?
    end

    if bracket[1].kind_of?(Array)
      html += bracket_render(bracket[1])
    else
      html  = render_to_string(:partial => 'brackets/s2', :locals => { :game => bracket[0] } )
      html += render_to_string(:partial => 'brackets/s2', :locals => { :game => bracket[1] } ) if ! bracket[1].nil?
    end

    return html
  end

end