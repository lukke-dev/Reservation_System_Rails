class BooksController < ApplicationController
  before_action :set_book, only: %i[ edit update destroy ]

  def index   
    respond_to do |format|
      format.html do
        @q = Book.includes(:category).ransack(params[:q])
        @pagy, @books = pagy(@q.result)
      end
      format.csv { send_data Book.as_csv }
    end
  end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_path, flash: { notice: "Book was successfully created." }}
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to books_path, notice: "Book was successfully updated." }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def download_csv_template
    csv_string = generate_csv(Book::IMPORT_CSV)
    respond_to do |format|
      format.csv do
        send_data "\uFEFF" + csv_string, type: :csv, filename: 'books_template.csv'
      end
    end
  end

  def import; end

  def import_file
    folder = File.join(Rails.root.join('tmp', 'imports'))
    FileUtils.mkdir_p(folder) unless Dir.exist?(folder)

    filename = "#{SecureRandom.alphanumeric(10)}-import-books.csv"
    path = File.join(folder, filename)

    File.open(path, 'wb') { |f| f.write(CSV.parse(params[:file].tempfile)) }
    
    ImportCsvWorker.perform_async(filename)
    redirect_to import_books_path, notice: 'A importação está sendo processada...'
  end

  private

  def set_book
    @book = Book.includes(:category).find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :category_id)
  end
end
