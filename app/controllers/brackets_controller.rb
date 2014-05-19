class BracketsController < ApplicationController

  def show
    @bracket    = Bracket.find(params[:id])
    @tournament = @bracket.tournament
    @teams      = @tournament.standings

    @rounds = []
    @bracket.rounds.each do |r|
      @rounds << bracket_render(r)
    end

    @h1 = @tournament.name
  end

  def edit
    @bracket = Bracket.find(params[:id])
    @bracket.games.each do |g|
      g.destroy
    end
    redirect_to @bracket
  end

  ###

  def bracket_render(bracket)
    html = ''

    if bracket[0].kind_of?(Array)
      # html += bracket_render(bracket[0].clone)
      html += bracket_render(bracket[0])
    else
      html  = bracket_render_game(bracket[0])
      html += bracket_render_game(bracket[1]) unless bracket[1].nil?
    end

    if bracket[1].kind_of?(Array)
      html += bracket_render(bracket[1])
    else
      html  = bracket_render_game(bracket[0])
      html += bracket_render_game(bracket[1]) unless bracket[1].nil?
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

    g = game.away.nil? ? 'nil' : game.away.name
    render_to_string(:partial => 'brackets/s2', :locals => {
      :game      => game,
      :view_home => view_home,
      :prev_home => prev_home,
      :view_away => view_away,
      :prev_away => prev_away
    })
  end

end