class ApplicationController < ActionController::Base
  skip_forgery_protection

  def index
    render inline: '', layout: 'application'
  end

  rescue_from CanCan::AccessDenied do
    head :forbidden
  end
end
