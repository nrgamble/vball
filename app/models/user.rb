class User
  include MongoMapper::Document

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable#, :recoverable, :trackable, :validatable

  # attr_accessible :email, :password, :password_confirmation, :remember_me, :remember_created_at

  key :email, String
  key :encrypted_password, String
  key :remember_created_at, Time
  # key :created_at, Time
  # key :updated_at, Time

  timestamps!

  def email_name
    email.split('@')[0]
  end

  def runs_tournament?(tournament)
    id == tournament.user_id
  end

end