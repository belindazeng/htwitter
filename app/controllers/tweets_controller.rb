class TweetsController < ApplicationController
	# links to the form
	def new
		# create a new instance of tweet (which is a model)
		@tweet = Tweet.new
	end

	# creates a new tweet
	# we need to define create action, so our controller knows which page to send to
	def create
		# entirely different tweet from the previous
		@tweet = Tweet.new(tweet_params)
		
		# save tweet to the database
		if @tweet.save

			# function in ruby
			# flash says survive one redirect before dying
			flash[:success] = "You have created a tweet"
		
			# render vs redirect
			redirect_to new_tweet_path
		end
		# goes back to new
		#render 'new'
	end

	def index
		
		@tweets = Tweet.all
	end 

	# need to sanitize input else forbidden access

	def tweet_params
		params.require(:tweet).permit(:content)
	end
end
