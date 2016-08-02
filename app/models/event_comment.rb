class EventComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :body, presence: true, length: {minimum: 2, maximum: 400}
end
