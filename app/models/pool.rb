class Pool
  include MongoMapper::Document

  key :tournament_id, ObjectId
  key :name, String

  timestamps!
  
  belongs_to :tournament
  
  many :teams
  many :games
  
  def standings
    return self.teams.sort! { |x,y| Team.sort_standings(y, x) }
  end
  
end