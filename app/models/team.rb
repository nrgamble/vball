class Team
  include MongoMapper::Document

  key :name, String, :required => true
  key :pool_id, ObjectId

  timestamps!
end