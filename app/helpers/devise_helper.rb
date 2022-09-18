module DeviseHelper
	def define_method
		resource.new_record? ? :post : :put
	end
end