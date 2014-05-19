class Pool
  include MongoMapper::Document

  key :tournament_id, ObjectId
  key :name, String

  timestamps!
  
  belongs_to :tournament
  
  many :teams, :dependent => :destroy
  many :games
  
  def standings
    teams.sort! { |x,y| Team.sort_standings(y, x) }
  end

  def schedule
    games.sort! { |x,y| x.date <=> y.date }
  end
  
end