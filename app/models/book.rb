class Book
  include MongoMapper::Document

  many :translations
end

class Translation
  include MongoMapper::EmbeddedDocument
  key :title, String
  key :short, String
  key :body, String
  key :language, String
end