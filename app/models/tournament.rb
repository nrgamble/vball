class Tournament
  include MongoMapper::Document

  key :name, String
  key :date, Time

  timestamps!
  
  has_many :teams
  has_many :pools
end