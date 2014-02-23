class Skill
  include MongoMapper::Document

  many :skill_translations
  
  def find_translation(language)
    skill_translations.detect { |t| t.language == language }
  end
end

class SkillTranslation
  include MongoMapper::EmbeddedDocument
  key :name, String
  key :short, String
  key :language, String
end