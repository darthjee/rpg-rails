class BooksController < ApplicationController

  before_filter :find_object, :except => [:index]
  before_filter :form_url, :only => [:edit, :new]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @translation = BookTranslation.new

    render "new"
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @translation = BookTranslation.new(params[:book_translation])
    @book.book_translations.push @translation

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    respond_to do |format|
      if @translation.update_attributes(params[:book_translation])
        format.html { redirect_to @book, notice: 'Translation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @translation.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  def destroy_translation
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private

  def find_object
    @book = params.has_key?(:id) ? Book.find(params[:id]) : Book.new
    @translation = @book.find_translation(params[:lang]) if params.has_key? :lang
  end

  def form_url
    @url = if not params.has_key?(:id)
      books_path
    elsif not (params.has_key?(:lang))
      book_path(params[:id])
    else
      update_translation_book_path(params[:id],params[:lang])
    end
  end

end
