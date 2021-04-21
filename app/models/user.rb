class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # STOCK AUTH SETTINGS
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
  #
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  # alternate blacklist JWT Deny mechanism
  #:jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  ##
  # USER should have a set of accounts
  # ? maybe polimorphic
  # - at least one checking account type
  # - add operation log to accounts
  #
  has_many :checking_accounts

  ##
  # Transfers money out of the account
  def do_withdraw(account_number, amount)
    account = self.checking_accounts.where(:clabe => account_number).first
    return unless !account.nil? ## probably handle some exception here
    account.do_withdraw(amount)
  end

  ##
  # Deposits a certain amount to the account
  def do_deposit(account_number, amount)
    account = self.checking_accounts.where(:clabe => account_number).first
    return unless !account.nil? ## probably handle some exception here
    account.do_deposit(amount)

  end
end
