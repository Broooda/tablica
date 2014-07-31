class RaportsController < ApplicationController
  
	def index
		@raports=Raport.all
	end


	# def new
	# 	@raport=Raport.new
	# end

	# def create
	# 	@raport = Raport.new(raport_params)
	# 	if @raport.save
	# 		redirect_to raports_path, notice: "Utworzono"
	# 	else
	# 		render new
	# 	end
	# end

	def pdf_view
<<<<<<< HEAD
			this_raport = Raport.generate_raport(params[:start], params[:end], current_user.id)
      #@raports = Raport.where(user_id = current_user.id)
=======
		#start, end, ID usera ktorego chcemy wygenerowac, obecny user
			this_raport = Raport.generate_raport(params[:start], params[:end], current_user.id, current_user)
			
			
 			
>>>>>>> 544e13b48b9945ec5da185037e557b46136b3fba
 			@work = this_raport.work_hours
      @holiday = this_raport.holiday_hours
      @raport_start = params[:start]
      @raport_end = params[:end]


  #   file=WickedPdf.new.pdf_from_string(
  # 		render_to_string('pdf_view.pdf.haml', :layout => 'raport.html'),
 	# 		:footer => {
  #   		:content => render_to_string(:layout => 'raport.html')
  # 		}
		# )

  #     Mailer.raport(current_user, file).deliver

      respond_to do |format|
        #format.html
        format.pdf do render :pdf => "generated.pdf", :layout => 'raport.html'
        end
      end

      #redirect_to pdf_view_test_path
		  
		end

		def generate_email
				Mailer.raport(current_user.email, params[:raport])
		end
	end



