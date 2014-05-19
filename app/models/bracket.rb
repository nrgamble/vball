class Bracket
  include MongoMapper::Document

  key :tournament_id, ObjectId

  timestamps!
  
  belongs_to :tournament

  many :games

  def num_teams
    i = 1
    x = 0
    while x == 0 do
      s = 2 ** i
      x = s if tournament.teams.size <= s
      i += 1
    end
    return x
  end

  def num_games
    num_teams - 1
  end

  # TODO: replace with log(base, num) when you get Ruby 1.9.x upgrade working
  def num_rounds
    (Math.log(teams.size) / Math.log(2)).to_i
  end

  def teams
    standings = tournament.standings
    (1..(num_teams - tournament.teams.size)).each do
      standings << Team.new
    end
    return standings
  end

  def rounds
  # benchmark('finding rounds') do
    rounds = []
    (1..num_rounds).each do |r|
      rounds << round(r)
    end
  # end
    return rounds
  end

  def round(r)
    if r == 1
      return seeded
    else
      if games_in_round(r).size.zero?
        (1..num_games_in_round(r)).each do
          games.create({ :tournament_id => tournament.id, :score_home => 0, :score_away => 0 })
          # games.new(:tournament_id => tournament.id)
        end
      end
      return games_in_round(r)
    end
  end

  def games_in_round(r)
    t = 0
    (1...r).each do |i|
      t += num_games_in_round(i)
    end
    g = games.slice(t, num_games_in_round(r))
    g = [] if g.nil?
    return g
  end

  def num_games_in_round(r)
    teams.size / (r * 2)
  end

  def layout
    _layout(num_teams)
  end

  def seeded
    _seed(layout, teams)
  end

  def generated?
    games.size == num_games
  end

private

  def _layout(_size)
    _size == 2 ? _size : [ _layout(_size / 2), _layout(_size / 2) ]
  end

  def _seed(_bracket, _teams)
    if _bracket.kind_of?(Array)
      lbracket, rbracket = _bracket
      lteams, rteams     = _split(_teams)
      return [ _seed(lbracket, lteams), _seed(rbracket, rteams) ]
    else
      if generated?
        _search_games(_teams[0].id, _teams[1].id)
      else
        games.create({
          :tournament_id => tournament.id,
          :home_id       => _teams[0].id,
          :away_id       => _teams[1].id,
          :score_home    => 0,#_teams[1].new? ? 1 : 0,
          :score_away    => 0
        })
      end
    end
  end

  def _split(_teams)
    left = []
    0.step(_teams.size, 4) { |i|
      left << _teams[i - 1] unless i.zero?
      left << _teams[i]     unless _teams[i].nil?
    }
    right = []
    2.step(_teams.size, 4) { |i|
      right << _teams[i - 1]
      right << _teams[i] unless _teams[i].nil?
    }
    return [ left, right ]
  end

  def _search_games(home_id, away_id)
    games.each do |g|
      return g if g.home_id = home_id and g.away_id = away_id
    end
  end
  
end