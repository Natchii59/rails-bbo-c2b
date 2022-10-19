class Api::WidgetsController < ApplicationController
  load_and_authorize_resource :except => [:get_by_token]

  # GET /widgets
  def index
    render json: Widget.accessible_by(current_ability).all.to_json(:include => { :product => { :only => :name } })
  end

  # GET /widgets/1
  def show
    render json: @widget.to_json(:include => { :product => { :only => :name } })
  end

  # POST /widgets
  def create
    @widget = Widget.new widget_params

    if @widget.save
      render json: @widget, status: :created
    else
      render json: @widget.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /widgets/1
  def update
    if @widget.update(widget_params)
      render json: @widget, status: :ok
    else
      render json: @widget.errors, status: :unprocessable_entity
    end
  end

  # DELETE /widgets/1
  def destroy
    @widget.destroy

    head :no_content
  end

  def get_by_token
    if request.headers['Authorization'] != Rails.application.secrets[:widget_token]
      raise CanCan::AccessDenied
    end

    begin
      render json: Widget.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

  end

  private

  # Only allow a list of trusted parameters through.
  def widget_params
    params.require(:widget).permit(:name, :product_id)
  end
end
