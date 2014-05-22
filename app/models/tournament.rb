class Tournament
  include MongoMapper::Document

  key :user_Id, ObjectId
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

  def pools_ready?
    teams.each do |t|
      return false if t.pool.nil?
    end
    true
  end
  
end