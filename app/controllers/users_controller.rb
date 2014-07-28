class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :mine_or_admin, except: [:index, :show ]


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
		@users = User.order('surname')
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

    respond_to do |format|
      format.html
      format.pdf do
      render :pdf => "generated.pdf"
    end
	end

  def make_admin
    @user = User.find(params[:id])
    @user.admin = true
    @user.save
    redirect_to users_url
  end

  def unmake_admin
    @user = User.find(params[:id])
    @user.admin = false
    @user.save
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :tags)
    end

    def mine_or_admin
      @user = User.find(params[:id])
      unless current_user.id == @user.id or current_user.admin == true
        redirect_to user_path, alert: "You can't edit that."
      end
      true
    end
end
end
