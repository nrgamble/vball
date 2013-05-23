class BracketsController < ApplicationController
    
  def new
    @tournament = Bracket.new
    @tournament.date = DateTime.now
    
    @h1 = 'New Bracket'
  end

  def show
    @bracket    = Bracket.find(params[:id])
    @tournament = @bracket.tournament
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

  def create
    @bracket = Bracket.new(params[:bracket])

    if @bracket.save
      #Bracket.new({ :tournament_id => @tournament.id }).save # TODO: do this with model association create
      redirect_to @bracket
    else
      render :action => :new
    end
  end

  ###

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