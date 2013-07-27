class Book
  include MongoMapper::Document

  many :book_translations
end

class BookTranslation
  include MongoMapper::EmbeddedDocument
  key :title, String
  key :short, String
  key :body, String
  key :language, String
end