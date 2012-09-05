class Tournament
  include MongoMapper::Document

  key :name, String, :required => true
  key :date, Time, :required => true

  timestamps!
end