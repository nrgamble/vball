class Team
  include MongoMapper::Document

  key :tournament_id, ObjectId
  key :pool_id, ObjectId
  key :name, String

  timestamps!
  
  belongs_to :tournament
  belongs_to :pool
  
  def games
    return Game.where(:$or => [ { :away_id => self.id }, { :home_id => self.id } ]).all
  end
  
  def wins
    wins = Array.new
    self.games.each do |g|
      if (g.home_id == self.id and g.score_home > g.score_away) or (g.away_id == self.id and g.score_away > g.score_home)
        wins << g
      end
    end
    return wins
  end
  
  def losses
    losses = Array.new
    self.games.each do |g|
      if (g.home_id == self.id and g.score_home < g.score_away) or (g.away_id == self.id and g.score_away < g.score_home)
        losses << g
      end
    end
    return losses
  end
  
  def win_percentage
    return self.games.length == 0 ? 0 : self.wins.length.to_f / self.games.length.to_f
  end
  
  def differential
    differential = 0
    self.games.each do |g|
      if g.winner?(self)
        differential += (g.score_winner - g.score_loser)
      else
        differential -= (g.score_winner - g.score_loser)
      end
    end
    return differential
  end
  
  def head2head(team)
    head2head = [0, 0]
    self.games.each do |g|
      if g.home_id == team.id or g.away_id == team.id
        g.winner?(self) ? head2head[0] += 1 : head2head[1] += 1
      end
    end
    return head2head
  end
  
end