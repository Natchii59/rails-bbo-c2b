class Api::WidgetsController < ApplicationController
  before_action :set_widget, only: [:show, :update, :destroy]

  # GET /widgets
  def index
    render json: Widget.all.to_json(:include => { :product => { :only => :name } })
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_widget
    @widget = Widget.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def widget_params
    params.require(:widget).permit(:name, :product_id)
  end
end
