class Profile < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :languages
  has_many :ratings
  has_many :reports_as_reporter, class_name: 'Report', foreign_key: 'reporter_id'
  has_many :reports_as_opponent, class_name: 'Report', foreign_key: 'opponent_id'

  # has_many :profile_name_edits

  before_save :make_default_if_there_are_not_any

  COLOR_REGEX = /\A#([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?\z/
  validates :user_id, presence: true
  validates :color, format: COLOR_REGEX, allow_nil: true


  NAME_REGEX = /\A(\w|\.|-)+\z/
  MUST_HAVE_LETTER_REGEX = /[a-zA-Z]+/
  # validates :profile_id, presence: true
  validates :name, presence: true
  validates :name, format: NAME_REGEX
  validates :name, format: MUST_HAVE_LETTER_REGEX
  validates :name, length: { maximum: 24, minimum: 3 }


  def make_default
    self.user.profile_id = self.id
    self.user.save
  end

  def self.by_user(user)
    return false if user == nil
    Profile.where user_id: user.id
  end

  private

  def make_default_if_there_are_not_any
    owner = self.user
    unless owner.current_profile
      owner.current_profile = self
      owner.save
    end
  end

end
