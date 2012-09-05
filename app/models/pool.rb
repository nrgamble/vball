class Pool
  include MongoMapper::Document

  key :name, String, :required => true
  key :tournament_id, ObjectId

  timestamps!
end