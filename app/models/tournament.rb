class Tournament
  include MongoMapper::Document

  key :name, String
  key :date, Time

  timestamps!
  
  many :teams
  many :pools
  
  def standings
    return self.teams.sort! { |x,y| Team.sort_standings(y, x) }
  end
  
end