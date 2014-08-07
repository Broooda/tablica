class RaportsController < ApplicationController
  
	def index
		@raports=Raport.all
	end

	def new
	  @raport=Raport.new
	end

	def pdf_view
    # start, end, ID usera ktorego chcemy wygenerowac, obecny user
  	this_raport = Raport.generate_raport(params[:start], params[:end], current_user.id, current_user)
    if this_raport.save
      @raport = this_raport
      if params[:send_email]
        file=WickedPdf.new.pdf_from_string(
          render_to_string('pdf_view.pdf.haml', :layout => 'raport.html'),
         :footer => {
         :content => render_to_string(:layout => 'raport.html')
         }
        )
        Mailer.raport(current_user, file).deliver
      end
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
    this_raport.each do |raport|
      if raport.save
        @raports[counter]=raport
        counter+=1
      else
        redirect_to new_raport_path, alert: "Wrong date"
      end
    end
    if params[:mail]
      file=WickedPdf.new.pdf_from_string(
        render_to_string('pdf_admin_view.pdf.haml', :layout => 'raport.html'),
       :footer => {
       :content => render_to_string(:layout => 'raport.html')
       }
      )
      Mailer.raport(current_user, file).deliver
    end
    respond_to do |format|
      format.pdf do render :pdf => "generated.pdf", :layout => 'raport.html'
      end
    end
  end

end



