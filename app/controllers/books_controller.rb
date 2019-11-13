class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # /books/searcBook?authore="test"
  def searchBook
    if (params.has_key?(:author))
      key= "author"
      val = JSON.parse(params["author"])
      book = getData(key, val)
    elsif( params.has_key?(:title))
      key= "title"
      val = JSON.parse(params["title"])
      book = getData(key, val)
    elsif( params.has_key?(:description))
      key= "description"
      val = JSON.parse(params["description"])
      book = getData(key, val)
    else
      book = {}
    end
    $redis.set val, book.to_json if val

    render json: {data: book}

  end

  private

    def getData(key, val)
      if $redis.get(val)
        book = JSON.parse($redis.get(val))
        puts "=======result from REDISH========"
      else
        book = Book.where("#{key}": val)
        puts "=======result from DB=========="
      end
      return book
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author, :isbn, :description, :language, :cover_image)
    end
end
