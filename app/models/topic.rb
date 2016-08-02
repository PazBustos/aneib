class Topic < ActiveRecord::Base
	belongs_to :user
	has_many :articles, dependent: :destroy 
	validates :title, presence: true, uniqueness: true, length: {maximum: 150}
	validates :description, presence: true, length: {maximum: 10000}
end
