class FollowsController < ApplicationController
	def create 
		# because Parameters has "follows" -> want to get at the number
		# "follows" => {"user" => "2"}
		# @user holds the number of the user id we want to follow
		@user = User.find(params[:follows][:user])
		# follow the current user as per the github page
		current_user.follow(@user)
		redirect_to tweets_path
	end 
end
