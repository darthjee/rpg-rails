class Book
  include MongoMapper::Document

  many :book_translations
  
  def find_translation(language)
    book_translations.detect { |t| t.language == language }
  end
end

class BookTranslation
  include MongoMapper::EmbeddedDocument
  key :title, String
  key :short, String
  key :language, String
end