class Profile < ActiveRecord::Base
  belongs_to :user

  has_and_belongs_to_many :languages

  before_save :make_default_if_there_are_not_any

  COLOR_REGEX = /\A#([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?\z/
  validates :user_id, presence: true
  validates :color, format: COLOR_REGEX, allow_nil: true

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
    unless owner.default_profile
      owner.default_profile = self
      owner.save
    end
  end

end
