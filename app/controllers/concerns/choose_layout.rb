module ChooseLayout
	extend ActiveSupport::Concern

	included do
    layout :choose_layout
  end

	def choose_layout
		['devise/passwords', 'users/sessions'].include?(params[:controller]) ? 'sign_in' : 'application'
	end
end