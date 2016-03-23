class Profile < ActiveRecord::Base
  belongs_to :user

  COLOR_REGEX = /\A#([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?\z/
  validates :user_id, presence: true
  validates :color, format: COLOR_REGEX, allow_nil: true
end
