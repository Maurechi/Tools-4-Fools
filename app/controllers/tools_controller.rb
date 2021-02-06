class ToolsController < ApplicationController
  # before_action :set_user, only: :create
  before_action :set_tool, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @tools = policy_scope(Tool).where(title: params[:query])
    else
      @tools = policy_scope(Tool).order(created_at: :desc)
    end

    @markers = @tools.geocoded.map do |tool|
      {
        lat: tool.latitude,
        lng: tool.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { tool: tool }),
        image_url: helpers.asset_url("marker.png")
      }
    end
  end

  def show
    authorize @tool
    @reservation = Reservation.new
    @marker = [{
      lat: @tool.latitude,
      lng: @tool.longitude,
      image_url: helpers.asset_url("marker.png")
    }]
  end

  def new
    @tool = Tool.new
    authorize @tool
  end

  def create
    @tool = Tool.new(tool_params)
    authorize @tool
    @tool.user_id = @current_user.id
    if @tool.save
      redirect_to tool_path(@tool)
    else
      render :new
    end
  end

  private

  def tool_params
    params.require(:tool).permit(:title, :description, :price, :photo, :address)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_tool
    @tool = Tool.find(params[:id])
  end
end
