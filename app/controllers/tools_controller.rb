class ToolsController < ApplicationController
  before_action :set_user, only: :create
  before_action :set_tool, only: :show

  def index
    @tools = policy_scope(Tool).order(created_at: :desc)
  end

  def show
    authorize @tool
  end

  def new
    @tool = Tool.new
    authorize @tool
  end

  def create
    @tool = Tool.new(tool_params)
    authorize @tool
    @tool.user_id = @user
    if @tool.save
      redirect_to tool_path(@tool)
    else
      render :new
    end
  end

  private

  def tool_params
    params.require(:tool).permit(:title, :description, :price)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_tool
    @tool = Tool.find(params[:id])
  end
end
