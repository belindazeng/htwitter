class Tweet < ActiveRecord::Base
	belongs_to :user

	# validate that a tweet is less than 140 characters
	validates :content, length: { maximum: 140 }
end
