class Tournament
  include MongoMapper::Document

  key :name, String
  key :date, Time
  key :location, String

  timestamps!
  
  many :pools, :dependent => :destroy
  many :teams
  
  def standings
    self.teams.sort! { |x,y| Team.sort_standings(y, x) }
  end

  def self.bracket_create(size)
    if size < 4
      return size
    else
      bracket  = []
      div, mod = size.divmod(2)
      if mod.zero?
        bracket << bracket_create(div)
        bracket << bracket_create(div)
      else
        up = down = 0
        size.step(0, -4) { |i| # TODO: find out (mathematically) why this is the case
          up += 1   if i == 5
          down += 1 if i == 7
        }
        bracket << bracket_create(div + up)
        bracket << bracket_create(div + down)
      end
      return bracket
    end
  end

  def self.bracket_fill(bracket, teams)

  end
  
end