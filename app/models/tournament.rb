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

  def bracket
    bracket = Tournament.bracket_create(teams.size)
    bracket = Tournament.bracket_fill(bracket, teams)
  end

  def self.bracket_create(size, first = true)
    if size < 4
      return first ? [ size ] : size
    else
      bracket  = []
      div, mod = size.divmod(2)
      if mod.zero?
        bracket = [ bracket_create(div, false), bracket_create(div, false) ]
      else
        up = down = 0
        size.step(0, -4) { |i| # TODO: find out (mathematically) why this is the case
          up += 1   if i == 5
          down += 1 if i == 7
        }
        bracket = [ bracket_create(div + up, false), bracket_create(div + down, false) ]
      end
      return bracket
    end
  end

  def self.bracket_split(teams)
    left = []
    0.step(teams.size, 4) { |i|
      left << teams[i-1] unless i.zero?
      left << teams[i]   unless teams[i].nil?
    }
    right = []
    2.step(teams.size, 4) { |i|
      right << teams[i-1]
      right << teams[i] unless teams[i].nil?
    }
    return [ left, right ]
  end

  def self.bracket_fill(bracket, teams)
    if bracket.kind_of?(Array)
      lbracket, rbracket = bracket
      lteams, rteams = bracket_split(teams)
      return [ bracket_fill(lbracket, lteams), bracket_fill(rbracket, rteams) ]
    else
      return teams
    end
  end
  
end