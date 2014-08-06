class RaportsController < ApplicationController
  
	def index
		@raports=Raport.all
	end

	def new
	  @raport=Raport.new
	end

	def pdf_view
    #start, end, ID usera ktorego chcemy wygenerowac, obecny user
  	this_raport = Raport.generate_raport(params[:start], params[:end], current_user.id, current_user)
    if this_raport.save
  		@work = this_raport.work_hours
      @holiday = this_raport.holiday_hours
      @over_hours=this_raport.over_hours
      @raport_start = params[:start]
      @raport_end = params[:end]
      respond_to do |format|
        format.pdf do render :pdf => "generated.pdf", :layout => 'raport.html'
      end
    end
    else
      redirect_to new_raport_path, alert: "Wrong date"
    end

  end
    
  def pdf_admin_view
    this_raport = Raport.generate_admin_raport(params[:start], params[:end], current_user)
    counter=0
    @raports=[]
    @work=[]
    @holiday=[]
    @over_hours=[]
    this_raport.each do |raport|
      if raport.valid?
        raport.save
        @raports[counter]=raport
        @work[counter] = raport.work_hours
        @holiday[counter] = raport.holiday_hours
        @over_hours[counter]=raport.over_hours
        @raport_start = params[:start]
        @raport_end = params[:end]
        counter+=1
      else
        redirect_to new_raport_path, alert: "Wrong date"
      end
    end
    respond_to do |format|
      #format.html
      format.pdf do render :pdf => "generated.pdf", :layout => 'raport.html'
    end
  end
  end

end



