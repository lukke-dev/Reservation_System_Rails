class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ edit update destroy ]

  def index
    respond_to do |format|
      format.html do
        set_objects_to_select
        params[:q] = params[:q]&.merge(user_id_eq: current_user.id) || { user_id_eq: current_user.id } unless current_user.is_admin
        @q = Reservation.includes(:user, :book).ransack(params[:q])
        @pagy, @reservations = pagy(@q.result)
      end
      format.csv { send_data Reservation.as_csv }
    end
  end

  def new
    @reservation = Reservation.new
  end

  def edit; end

  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservations_path, notice: "Reservation was successfully created." }
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservations_path, notice: "Reservation was successfully updated." }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:user_id, :book_id, :booking_date, :return_date, :booking_status)
  end

  def set_objects_to_select
    @users = User.select(:id, :name)
    @books = Book.select(:id, :title)
  end
end
