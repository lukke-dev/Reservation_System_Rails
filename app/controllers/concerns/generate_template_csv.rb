module GenerateTemplateCsv
  extend ActiveSupport::Concern

  def generate_csv(fields)
    CSV.generate do |csv|
      csv << fields
    end
  end
end
