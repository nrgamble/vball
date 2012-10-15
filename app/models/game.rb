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
  
  before_save :same_team
  after_save :teams_caches
  
  def winner
    score_home > score_away ? self.home : self.away
  end
  
  def winner?(team)
    team == self.winner
  end
  
  def loser
    score_home > score_away ? self.away : self.home
  end
  
  def loser?(team)
    team == self.loser
  end
  
  def score_winner
    score_home > score_away ? score_home : score_away
  end
  
  def score_loser
    score_home > score_away ? score_away : score_home
  end
  
  private
  
    def same_team
      raise Exception if self.home_id == self.away_id
    end
  
    def teams_caches
      self.away.plus_minus = self.away.calculate_plus_minus
      self.away.win_percentage = self.away.calculate_win_percentage
      self.away.save
      
      self.home.plus_minus = self.home.calculate_plus_minus
      self.home.win_percentage = self.home.calculate_win_percentage
      self.home.save
    end
  
end