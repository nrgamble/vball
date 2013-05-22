class Team
  include MongoMapper::Document

  key :tournament_id, ObjectId
  key :pool_id, ObjectId
  key :name, String
  key :win_percentage, Float
  key :plus_minus, Integer

  timestamps!
  
  belongs_to :tournament
  belongs_to :pool
  
  def destroy
    games.each do |g|
      g.destroy
    end
    super
  end
  
  def games
    Game.where(:bracket_id => nil, :$or => [ { :away_id => id }, { :home_id => id } ]).all
  end
  
  def wins
    wins = Array.new
    games.each do |g|
      if (g.home_id == id and g.score_home > g.score_away) or (g.away_id == id and g.score_away > g.score_home)
        wins << g
      end
    end
    return wins
  end
  
  def losses
    losses = Array.new
    self.games.each do |g|
      if (g.home_id == id and g.score_home < g.score_away) or (g.away_id == id and g.score_away < g.score_home)
        losses << g
      end
    end
    return losses
  end
  
  def calculate_win_percentage
    games.size == 0 ? 0 : wins.size.to_f / games.size.to_f
  end
  
  def calculate_plus_minus
    plus_minus = 0
    games.each do |g|
      if g.winner?(self)
        plus_minus += (g.score_winner - g.score_loser)
      else
        plus_minus -= (g.score_winner - g.score_loser)
      end
    end
    return plus_minus
  end
  
  def head2head(team)
    head2head = [0, 0]
    games.each do |g|
      if g.home_id == team.id or g.away_id == team.id
        g.winner?(self) ? head2head[0] += 1 : head2head[1] += 1
      end
    end
    return head2head
  end

  def place(standings)
    return standings.index(self) + 1
  end
  
  def self.sort_standings(x, y)
    if x.win_percentage == y.win_percentage
      if x.head2head(y)[0] > x.head2head(y)[1]
        return 1
      elsif x.head2head(y)[0] < x.head2head(y)[1]
        return -1
      else
        return x.plus_minus.to_i <=> y.plus_minus.to_i
      end
    else
      return x.win_percentage.to_f <=> y.win_percentage.to_f
    end
  end
  
end