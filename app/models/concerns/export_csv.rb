require 'csv'

module ExportCsv
	def as_csv
		attributes = self::EXPORT_CSV

		CSV.generate(headers: true) do |csv|
			csv << attributes.map{ |attr| I18n.t("activerecord.attributes.#{self.to_s.downcase}.#{attr}")}
			all.each do |object|
				csv << attributes.map do |attr|
					object.send(self::CHANGE_ATTRS[attr.to_sym] || attr)
				end
			end
		end
	end
end