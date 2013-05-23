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
    @bracket.rounds.each do |r|
      @rounds << bracket_render(r)
    end

    @h1 = @tournament.name
  end

  def bracket_render(bracket)
    html = ''

    if bracket[0].kind_of?(Array)
      html += bracket_render(bracket[0])
    else
      html = bracket_render_game(bracket[0])
      if not bracket[1].nil?
        html += bracket_render_game(bracket[1])
      end
    end

    if bracket[1].kind_of?(Array)
      html += bracket_render(bracket[1])
    else
      html = bracket_render_game(bracket[0])
      if not bracket[1].nil?
        html += bracket_render_game(bracket[1])
      end
    end

    return html
  end

  def bracket_render_game(game)
    view_home = 'brackets/s1'
    prev_home = nil
    if game.home.nil? and not game.previous_games.nil?
      view_home = 'brackets/s1u'
      prev_home = game.previous_games.shift
    end

    view_away = 'brackets/s1'
    prev_away = nil
    if game.away.nil? and not game.previous_games.nil?
      view_away = 'brackets/s1u'
      prev_away = game.previous_games.pop
    end

    render_to_string(:partial => 'brackets/s2', :locals => {
      :game      => game,
      :view_home => view_home,
      :prev_home => prev_home,
      :view_away => view_away,
      :prev_away => prev_away
    })
  end

end