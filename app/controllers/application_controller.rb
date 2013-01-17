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

  def url_options
    case Rails.env
    when 'development'
      {:host => 'localhost:3000'}.merge super
    when 'staging'
      {:host => 'staging.mybikelane.to'}.merge super
    when 'production'
      {:host => 'www.mybikelane.to'}.merge super
    end
  end
end
