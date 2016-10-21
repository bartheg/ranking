class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  has_many :profiles

  belongs_to :current_profile, class_name: 'Profile', foreign_key: 'profile_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable
  # :confirmable - disabled

  scope :super_admins,      -> { with_role(:super_admin) }
  scope :vice_super_admins, -> { with_role(:vice_super_admin) }
  scope :admins,            -> { with_role(:admin) }
  scope :vice_admins,       -> { with_role(:vice_admin) }
  scope :global_moderators, -> { with_role(:global_moderator) }
  scope :game_editors,      -> { with_role(:game_editor, :any) }
  scope :ranking_editors,   -> { with_role(:ranking_editor, :any) }
  scope :all_admins,        -> { with_any_role(:super_admin, :vice_super_admin, :admin, :vice_admin) }
  scope :all_staff_members, -> { with_any_role(:super_admin, :vice_super_admin, :admin, :vice_admin, :global_moderator, {name: :game_editor, resource: :any}, {name: :ranking_editor, resource: :any}) }

  scope :users,            -> { with_role(:user) }
  scope :new_users,        -> { with_role(:new_user) }
  scope :trusted_users,    -> { with_role(:trusted_user) }
  scope :blocked_users,    -> { with_role(:blocked_user) }
  scope :banned_users,     -> { with_role(:banned_user) }
  scope :evaporated_users, -> { with_role(:evaporated_user) }
  scope :not_banned_users, -> { with_any_role(:user, :new_user, :trusted_user, :blocked_user) }

end
