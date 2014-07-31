class RaportsController < ApplicationController
  
	def index
	end

	def pdf_view
			this_raport = Raport.generate_raport(params[:start], params[:end], current_user.id)

 			@work = this_raport.work_hours
      @holiday = this_raport.holiday_hours
      @raport_start = params[:start]
      @raport_end = params[:end]

      respond_to do |format|
        #format.html
        format.pdf do render :pdf => "generated.pdf", :layout => 'raport.html'
        end
      end

      #redirect_to pdf_view_test_path
		  
		end
	end



