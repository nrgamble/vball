class Game
  include MongoMapper::Document

  key :home_id, ObjectId
  key :away_id, ObjectId
  key :score_home, Integer
  key :score_away, Integer

  timestamps!
end