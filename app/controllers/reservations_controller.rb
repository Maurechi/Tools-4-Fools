class ReservationsController < ApplicationController
  before_action :set_tool, only: [:create, :new]

  # def create
  #   @reservation = Reservation.new(reservation_params)
  # # @reservation = Reservation.new(start: 1, end: 2)

  #   # raise
  #   @reservation.user = current_user
  #   @reservation.tool_id = @tool
  #   @reservation.status = "reserved"
  #   # raise
  #   authorize @reservation
  #   if @reservation.save!
  #     # raise
  #     redirect_to tools_path
  #   else
  #     # raise
  #     render 'tools/show'
  #   end
  # end

  def new
    @reservation = Reservation.new
    authorize @reservation
  end

   def create
    @reservation = Reservation.new(reservation_params)
    @reservation.tool = @tool
    @reservation.user = current_user
    authorize @reservation
    if @reservation.save
      redirect_to tools_path, notice: "Reservation successful!"
    else
      render 'tools/show'
    end
  end

  private

  def set_tool
    @tool = Tool.find(params[:tool_id])
  end

  def reservation_params
    params.required(:reservation).permit(:start, :end)
  end
end
