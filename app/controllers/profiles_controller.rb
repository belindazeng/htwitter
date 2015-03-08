class ProfilesController < ApplicationController
	before_action :authenticate_user!

	def new
		# creating a new instance of Profile
		@profile = Profile.new
	end

	# submit butotn won't work until you do a def create
	def create
		@profile = Profile.new(profile_params)

		@profile.user = current_user

		if @profile.save
			flash[:success] = "You have created a profile"
			redirect_to profile_path(current_user.profile)
		else
			render 'new'
		end
	end

	def show
		# getting information from the URL via params
		 @profile = Profile.find(params[:id])
	end


	def profile_params
		params.require(:profile).permit(:picture, :first_name, :description)
	end


end
