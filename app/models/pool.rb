class Pool
  include MongoMapper::Document

  key :tournament_id, ObjectId
  key :name, String

  timestamps!
  
  belongs_to :tournament
  
  many :teams, :dependent => :destroy
  many :games
  
  def standings
    self.teams.sort! { |x,y| Team.sort_standings(y, x) }
  end
  
end