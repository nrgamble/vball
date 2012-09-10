class Team
  include MongoMapper::Document

  key :tournament_id, ObjectId
  key :pool_id, ObjectId
  key :name, String

  timestamps!
  
  belongs_to :tournament
  belongs_to :pool
  
  def games
    return Game.where(['away_id = ? OR home_id = ?', self.id, self.id])
  end
  
  def wins
    wins = 0
    self.games.each do |g|
      if (g.home_id == self.id and g.score_home > g.score_away) or (g.away_id == self.id and g.score_away > g.score_home)
        wins += 1
      end
    end
    return wins
  end
  
  def losses
    losses = 0
    self.games.each do |g|
      if (g.home_id.eq?(self.id) and g.score_home < g.score_away) or (g.away_id.eq?(self.id) and g.score_away < g.score_home)
        losses += 1
      end
    end
    return losses
  end
  
end