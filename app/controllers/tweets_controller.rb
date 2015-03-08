class TweetsController < ApplicationController
	# exclamation mark is huge for raise an error, security, something bad can happen
	before_action :authenticate_user!

	# excepting certain things
	#before_action :authenticate_user!, except: :index
	#before_action :authenticate_user!, only: :index

	# links to the form
	def new
		# create a new instance of tweet (which is a model)
		@tweet = Tweet.new
		@testing = Tweet.all
	end

	# creates a new tweet
	# we need to define create action, so our controller knows which page to send to
	def create
		# entirely different tweet from the previous
		@tweet = Tweet.new(tweet_params)
		
		# because of the renders (doesn't save it otherwise)
		@testing = Tweet.all
		# assign a user
		@tweet.user = current_user

		

		# save tweet to the database
		if @tweet.save

			# function in ruby
			# flash says survive one redirect before dying
			flash[:success] = "You have created a tweet"
			

			# render vs redirect
			redirect_to new_tweet_path

		else 
			render 'new'
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
