require 'net/http'

class Tournament
  include MongoMapper::Document

  key :name, String
  key :date, Time

  timestamps!
  
  many :pools, :dependent => :destroy
  many :teams
  
  def standings
    self.teams.sort! { |x,y| Team.sort_standings(y, x) }
  end
  
  def bracket_url
    return 'UNCOMMENT THIS WHEN READY'
    uri = URI("http://www.printyourbrackets.com/#{self.teams.size}seeded.html")
    res = Net::HTTP.get_response(uri)
    if ! res.kind_of?(Net::HTTPSuccess)
      uri = URI("http://www.printyourbrackets.com/#{self.teams.size}-team-seeded-tournament-bracket.html")
      res = Net::HTTP.get_response(uri)
    end
    uri.to_s
  end
  
end