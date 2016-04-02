class ProfileNameEdit < ActiveRecord::Base
  belongs_to :profile

  NAME_REGEX = /\A(\w|\.|-)+\z/
  MUST_HAVE_LETTER_REGEX = /[a-zA-Z]+/
  validates :profile_id, presence: true
  validates :name, presence: true
  validates :name, format: NAME_REGEX
  validates :name, format: MUST_HAVE_LETTER_REGEX
  validates :name, length: { maximum: 24, minimum: 3 }

end
