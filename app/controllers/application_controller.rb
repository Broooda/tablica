class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception

  before_action :unaccepted_user
  before_action :authenticate_user!, except: [:go_to_login]
  before_action :get_inbox_msgs
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def get_inbox_msgs
    if current_user and current_user.admin
      @inbox_msgs = Holiday.where("status='pending'").size
      @inbox_msgs += DefaultWorkTimeRequest.where("status='pending'").size
      @inbox_msgs += OverHour.where("status='pending'").size
    
      if @inbox_msgs > 0
        @inbox_msgs = ' <span class="badge pulse">'+@inbox_msgs.to_s+'</span>'
      else
        @inbox_msgs = ' <span class="badge">0</span>';
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :surname
  end

  def go_to_login
  	redirect_to new_user_session_path, notice: 'You must log in.'
  end

  def unaccepted_user
    if current_user
      if current_user.accepted==false
        #redirect_to destroy_user_session_path, method: :delete, notice: 'Your account is not accepted yet.'
        sign_out current_user
        flash[:error] = "Your account is not accepted yet."
      end
    end
  end
end