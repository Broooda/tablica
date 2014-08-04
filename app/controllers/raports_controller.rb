class RaportsController < ApplicationController
  
	def index
		@raports=Raport.all
	end


 def new
 	@raport=Raport.new
 end

	# def create
	# 	@raport = Raport.new(raport_params)
	# 	if @raport.save
	# 		redirect_to raports_path, notice: "Utworzono"
	# 	else
	# 		render new
	# 	end
	# end

	def pdf_view
      # @raports = Raport.where(user_id = current_user.id)
		  # start, end, ID usera ktorego chcemy wygenerowac, obecny user
			this_raport = Raport.generate_raport(params[:start], params[:end], current_user.id, current_user)

      if this_raport.valid?
        this_raport.save
   			@work = this_raport.work_hours
        @holiday = this_raport.holiday_hours
        @raport_start = params[:start]
        @raport_end = params[:end]
      respond_to do |format|
        # format.html
        format.pdf do render :pdf => "generated.pdf", :layout => 'raport.html'
        end
      end
      else
      redirect_to new_raport_path, alert: "Wrong date"
		  end
		end
    def pdf_admin_view
      flag=0
      this_raport = Raport.generate_admin_raport(params[:start], params[:end], current_user)
        counter=0
        @raports=[]
        @work=[]
        @holiday=[]
        this_raport.each do |raport|
          if raport.valid?
            raport.save
            @raports[counter]=raport
            @work[counter] = raport.work_hours
            @holiday[counter] = raport.holiday_hours
            @raport_start = params[:start]
            @raport_end = params[:end]
            counter+=1
          else
            flag+=1
            redirect_to new_raport_path, alert: "Wrong date"
          end
        end
        if flag==0
    # Wysylanie raportu e-mailem (po wygenerowaniu go):
      file=WickedPdf.new.pdf_from_string(
       render_to_string('pdf_admin_view.pdf.haml', :layout => 'raport.html'),
       :footer => {
         :content => render_to_string(:layout => 'raport.html')
       }
    )
       Mailer.raport(current_user, file).deliver

      respond_to do |format|
        # format.html
        format.pdf do render :pdf => "generated.pdf", :layout => 'raport.html'
        end
      end
    else
      redirect_to new_raport_path, alert: "Wrong date"
    end
      

    end
	end



