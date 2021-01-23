class ToolsController < ApplicationController
  before_action :set_user, only: :create
  def index
    @tools = Tool.all
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
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
end
