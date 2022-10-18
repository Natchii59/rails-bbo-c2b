class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super do |user|
      render json: user
      return
    end
  end
end
