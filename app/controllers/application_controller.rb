class ApplicationController < ActionController::Base
  protect_from_forgery
  # check_authorization :unless => :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def feedback
    FeedbackMailer.feedback(params[:message], current_user).deliver

    respond_to do |format|
      format.json { render :json => "Thanks for the feedback!".to_json }
    end
  end
end
