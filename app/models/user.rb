class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :portals
	has_many :events
	has_many :financesic
	has_many :articles
	has_many :topics
	has_many :comments
end
