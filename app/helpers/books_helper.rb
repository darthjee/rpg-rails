module BooksHelper
    def form_path
      if not params.has_key?(:id)
        books_path
      elsif not (params.has_key?(:lang))
        book_path(params[:id])
      else
        update_translation_book_path(params[:id],params[:lang])
      end
    end
end
