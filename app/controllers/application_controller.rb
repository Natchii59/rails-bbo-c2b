class ApplicationController < ActionController::Base
  skip_forgery_protection

  def index
    render inline: '', layout: 'application'
  end
end
