class Tournament
  include MongoMapper::Document

  key :name, String
  key :date, Time
  key :location, String

  timestamps!
  
  one :bracket, :dependent => :destroy

  many :pools, :dependent => :destroy
  many :teams
  
  def standings
    self.teams.sort! { |x,y| Team.sort_standings(y, x) }
  end
  
end