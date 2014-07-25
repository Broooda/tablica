class UsersController < ApplicationController
  before_action :authenticate_user!


  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Edytowano"
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end


	def index
		@users = User.all
	end

	def accept
		@user = User.find(params[:id])
		@user.accepted = true
		@user.save
    DefaultWorkTime.create(week: [['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00'],['9:00','16:00']], user_id: @user.id)
		redirect_to users_url
	end
  
  	def show
    	@user=User.find(params[:id])
  	end

  def make_admin
    @user = User.find(params[:id])
    @user.admin = true
    @user.save
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
    end

end
