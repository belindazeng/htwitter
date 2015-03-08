class Tweet < ActiveRecord::Base
	belongs_to :user
	include Twitter::Extractor
	# defining something completely new, like yolo
	def get_hashtags
		#take that tweet, extract the hashtags from the tweet's content
		self.extract_hashtags(self.content)
	end
	# validate that a tweet is less than 140 characters
	validates :content, length: { maximum: 140 }

	# create a custom validation
	# validate is custom as opposed to validates from rails predone
	validate :hashtags_are_created

	def hashtags_are_created
		begin
			# transaction do 
			transaction do
				@hashtags = self.get_hashtags

				@hashtags.each do |the_hashtag| 
					# find something that meets this criteria
					if Hashtag.where(tag: the_hashtag).any?
						#do nothing
					else
						#create the hashtag
						# create does .new and .save both
						# ! because if the code doesn't work then rollback, breaks the code
						if Hashtag.create!(tag: the_hashtag)
							#do nothing
						else 
							# throw an error if for whatever reason a hashtag could not be made
							# for the users, not real users, don't create it, not a code error
							self.errors.add(:content, "Your hashtag #{the_hashtag} could not be created")
						end
					end
				end
			end 
		rescue
			self.errors.add(:base, "Your tweet has a bad hashtag")
		end
	end
end
