class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # STOCK AUTH SETTINGS
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable

  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  # alternate blacklist JWT Deny mechanism
  #:jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

end
