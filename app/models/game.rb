class Game
  include MongoMapper::Document

  key :tournament_id, ObjectId
  key :pool_id, ObjectId
  key :away_id, ObjectId
  key :home_id, ObjectId
  key :score_away, Integer
  key :score_home, Integer

  timestamps!
  
  belongs_to :tournament
  belongs_to :pool
  belongs_to :home, :class_name => 'Team'
  belongs_to :away, :class_name => 'Team'
end