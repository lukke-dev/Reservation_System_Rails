class HomeController < ApplicationController
	def index; end

	def dashboard
		reservations = Reservation.all.pluck(:book_id).tally
		qtd = reservations.values.tally.keys.max
		book_id = reservations.first[0]
		@data = {
			users_registereds: User.all.size,
			books_registereds: Book.all.size,
			reserveds: Reservation.all.size,
			more_reserved: Book.includes(:category).find(book_id),
			qtd: qtd
		}
	end
end
