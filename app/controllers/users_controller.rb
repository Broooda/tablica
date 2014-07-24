class UsersController < ApplicationController
  before_action :authenticate_user!

	def index
		@users = User.all
	end

	def accept
		@user = User.find(params[:id])
		@user.accept = true
		@user.save
		redirect_to users_url
	end
  
  	def show
    	@user=User.find(params[:id])
  	end
end
