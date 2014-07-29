class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :mine_or_admin, except: [:index, :show ]


  # def download 
  #   html = render_to_string(:action => :show, :layout => "pdf_layout.html") 
  #   pdf = WickedPdf.new.pdf_from_string(html) 
  #   send_data(pdf, 
  #     :filename    => "my_pdf_name.pdf", 
  #     :disposition => 'attachment') 
  # end

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
   
    @user.default_work_time.destroy_all
    @user.hours_plan.destroy_all
     @user.destroy
    redirect_to users_url
  end

	def index
		@users = User.order('surname')

    WickedPdf.config = {
      :exe_path => '/usr/local/bin/wkhtmltopdf'
    }

      respond_to do |format|
        format.html
        format.pdf do render :pdf => "generated.pdf", :layout => 'pdfgen.html.erb'
        end
      end
	end

	def accept
		@user = User.find(params[:id])
		@user.accepted = true
		@user.save
    DefaultWorkTime.create(week: [['9:00','17:00'],['9:00','17:00'],['9:00','17:00'],['9:00','17:00'],['9:00','17:00']], user_id: @user.id)
		
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

    respond_to do |format|
      format.html
      format.pdf do render :pdf => "generated.pdf", :layout => 'pdfgen'
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

