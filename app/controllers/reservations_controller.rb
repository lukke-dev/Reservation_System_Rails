class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ edit update destroy change_status ]
  before_action :set_objects_to_select, only: %i[ index new edit create update ]

  def index
    respond_to do |format|
      format.html do
        params[:q] = params[:q]&.merge(user_id_eq: current_user.id) || { user_id_eq: current_user.id } unless current_user.is_admin
        @q = Reservation.includes(:user, :book).order(:id).ransack(params[:q])
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
        format.html { redirect_to reservations_path, notice: I18n.t('successfully_created', model: I18n.t('activerecord.models.reservation.one')) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservations_path, notice: I18n.t('successfully_updated', model: I18n.t('activerecord.models.reservation.one')) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: I18n.t('successfully_destroyed', model: I18n.t('activerecord.models.reservation.one')) }
    end
  end

  def change_status
    @reservation.opened? ? @reservation.finished! : @reservation.opened!
    redirect_to reservations_path(q: query_params), notice: I18n.t('booking_status_updated')
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id] || params[:reservation_id])
  end

  def reservation_params
    params.require(:reservation).permit(:user_id, :book_id, :booking_date, :return_date, :booking_status)
  end

  def query_params
    params.require(:q).permit(:booking_date_date_equals, :return_date_date_equals, :user_id_eq, :book_id_eq, :booking_status_eq)
  end

  def set_objects_to_select
    @users = User.select(:id, :name).where(is_admin: false).order(:name)
    @books = Book.select(:id, :title).order(:title)
  end
end
