class Pool
  include MongoMapper::Document

  key :tournament_id, ObjectId
  key :name, String

  timestamps!
  
  belongs_to :tournament
  
  many :teams
  
  def standings
    return self.teams.sort! { |x,y| Pool.sort_standings(y, x) }
  end
  
  def self.sort_standings(x, y)
    if x.win_percentage == y.win_percentage
      if x.head2head(y)[0] > x.head2head(y)[1]
        return 1
      elsif x.head2head(y)[0] < x.head2head(y)[1]
        return -1
      else
        return x.differential <=> y.differential
      end
    else
      return x.win_percentage <=> y.win_percentage
    end
  end
  
end