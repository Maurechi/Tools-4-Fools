
class ReservationsController < ApplicationController
  before_action :set_tool, only: [:create, :new]

  def new
    @reservation = Reservation.new
    authorize @reservation
  end
# create
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.tool = @tool
    @reservation.user = current_user
    authorize @reservation
    if @reservation.save
      redirect_to reservations_path
      flash[:notice] = "Reservation successful!"
    else
      render 'tools/show'
    end
  end

  def index
    @reservations = policy_scope(Reservation).order(created_at: :desc)
    @all_reservations = current_user.reservations
    @all_tools = Tool.where(user_id: current_user)
  end


  private

  def set_tool
    @tool = Tool.find(params[:tool_id])
  end

  def reservation_params
    params.required(:reservation).permit(:start, :end)
  end
end
