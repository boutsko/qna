require "application_responder"



class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

#  check_authorization unless: :devise_controller?
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # rescue_from CanCan::AccessDenied do |exeption|
  #   redirect_to root_path, alert: exeption.message
  # end
  
end
