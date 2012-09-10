class Pool
  include MongoMapper::Document

  key :tournament_id, ObjectId
  key :name, String

  timestamps!
  
  belongs_to :tournament
  
  has_many :teams
end