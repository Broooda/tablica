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

   
    @user.default_work_time.destroy
    @user.hours_plan.destroy_all
    @user.holiday.destroy_all
     @user.destroy

    redirect_to users_url
  end

	def index
		@users = User.order('surname')

      respond_to do |format|
        format.html
        format.pdf do render :pdf => "generated.pdf", :layout => 'pdfgen.html'
        end
      end

	end

	def accept
		@user = User.find(params[:id])
		@user.accepted = true
		@user.save

    DefaultWorkTime.create(week: [['09:00','17:00'],['09:00','17:00'],['09:00','17:00'],['09:00','17:00'],['09:00','17:00']], user_id: @user.id)
		
    if HoursPlan.all.size > 0
      last=HoursPlan.order( 'start_date ASC' )
      last=last.last
      current_week=Time.now.to_date.cweek
      last_week=last.start_date.to_date.cweek
      difference=last_week-current_week
    else
      difference=6     
    end

     (0..difference).each do |counter|
      DefaultWorkTime.generate_hours_plans(counter, @user.id) 
  end

    redirect_to users_url
	end
  
	def show
  	@user=User.find(params[:id])

    earliest_hoursplan

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "generated.pdf"
      end
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

  def earliest_hoursplan
    now=DateTime.now
    @hours_plan = HoursPlan.where('user_id = :user_id and start_date > :now',{user_id: params[:id], now: now}).order('start_date').first
    #pobrac wszystkie rozpoczecia przeze mnie i usera
    #iterowac po nich i spr w kazdej czy jestesmy oboje w pracy
    #dopoki nie znajde wspolnego
    #or zamiast and

    #@hours_plan.each do |h|
# <<<<<<< HEAD
#     @commonhours = HoursPlan.where('(user_id = :user_id or user_id = :user_id2) and start_date > :now',{user_id: params[:id], user_id2: current_user.id, now: now}).order('start_date')
#       @commonhours.each do |c|
#         HoursPlan.where('start_date == now')
# #dla kazdego co znajdzie musi oytac. spr czy 1 i 2 uzzytk sa
#          if @userhours.start_date == @myhours.start_date
#         #   #success
#         if @commonhours.nil?
#           puts "Brak wspolnego terminu pracy"
#         end
# =======
    @first_common_hour = 'nope'
    commonhours = HoursPlan.where('(user_id = :user_id or user_id = :user_id2) and start_date > :now',{user_id: params[:id], user_id2: current_user.id, now: now}).order('start_date')
    commonhours.each do |c|
      is_man_working = (HoursPlan.where('user_id = :id and start_date <= :start and end_date >= :start', {id: params[:id], start: c.start_date}).size > 0)
      are_you_working = (HoursPlan.where('user_id = :id and start_date <= :start and end_date >= :start', {id: current_user.id, start: c.start_date}).size > 0)
      #dla kazdego co znajdzie musi oytac. spr czy 1 i 2 uzzytk sa
      if is_man_working and are_you_working
        @first_common_hour = c.start_date
        break
      end
    end
#>>>>>>> a34b640ad094a94afe9c4e0b92e953669833214a
      #end
    #end
  end

  private

    def user_params
      params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :tags)
    end

    def mine_or_admin
      @user = User.find(params[:id])
      unless current_user.id == @user.id or current_user.admin == true
        redirect_to users_path, alert: "You can't edit that."
      end
      true
    end

end


