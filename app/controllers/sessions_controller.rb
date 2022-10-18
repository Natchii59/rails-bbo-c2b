class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super do |user|
      render json: user.as_json.merge(rules: Ability.new(user).to_list), status: :created
      return
    end
  end
end
