class Tournament
  include MongoMapper::Document

  key :name, String
  key :date, Time

  timestamps!
  
  many :teams
  many :pools
end