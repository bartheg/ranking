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
end
