class ImportCsvService
  attr_accessor :path, :filename, :content

  def initialize(filename)
    @path = Rails.root.join('tmp', 'imports', filename).to_s
    @filename = filename
    @content = prepare_file(@path)
  end

  def perform
    begin
      return if @content.nil?
      prepare_objects
      create_records
      delete_file
    rescue => e
      puts e
    end
  end

  def prepare_file(path)
    JSON.parse(File.read(path)) rescue nil
  end

  def prepare_objects
    @content.delete_at(0)
    @content.map!{ |row| { title: row[0], author: row[1], category_id: row[2] }}
  end

  def create_records
    Book.transaction do
      Book.create!(@content)
    end
  end

  def delete_file
    File.delete(@path)
  end
end