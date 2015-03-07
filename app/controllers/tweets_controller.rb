class TweetsController < ApplicationController
	def new
		# create a new instance of tweet (which is a model)
		@tweet = Tweet.new
	end
end
