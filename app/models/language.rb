class Language < ActiveRecord::Base
  has_and_belongs_to_many :profiles


  ISO_REGEX = /\A([a-z]){2}\z/
  ENGLISH_NAME_REGEX = /[A-Z].*/
  validates :iso_639_1, presence: true
  validates :english_name, presence: true
  validates :iso_639_1, format: ISO_REGEX
  validates :english_name, format: ENGLISH_NAME_REGEX

end
