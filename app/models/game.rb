class Game
  include MongoMapper::Document

  key :tournament_id, ObjectId
  key :pool_id, ObjectId
  key :away_id, ObjectId
  key :home_id, ObjectId
  key :score_away, Integer
  key :score_home, Integer

  timestamps!
  
  belongs_to :tournament
  belongs_to :pool
  belongs_to :home, :class_name => 'Team'
  belongs_to :away, :class_name => 'Team'
  
  def winner
    return score_home > score_away ? self.home : self.away
  end
  
  def winner?(team)
    return team == self.winner
  end
  
  def loser
    return score_home > score_away ? self.away : self.home
  end
  
  def loser?(team)
    return team == self.loser
  end
  
  def score_winner
    return score_home > score_away ? score_home : score_away
  end
  
  def score_loser
    return score_home > score_away ? score_away : score_home
  end
  
end