class Contact < ActiveRecord::Base

	validates :name, presence: true, length: {maximum: 100}
	validates :email, presence: true, length: {maximum: 100}
	validates :subject, presence: true, length: {maximum: 100}
	validates :body, presence: true, length: {maximum: 10000}
end
