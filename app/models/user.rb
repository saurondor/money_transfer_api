##
# API User class
# Has two types ADMIN or HOLDER
# ADMIN has create account and add fund privileges
# HOLDER has checking accoun and transfer out privileges
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
  #

  validates :email, presence: true
  validates :role, presence: true

  has_many :checking_accounts

  ROLE_ADMIN = 'admin'
  ROLE_HOLDER = 'holder'

  def admin?
    role == ROLE_ADMIN
  end

  ##
  # Transfers money out of the account
  def do_withdraw(source_account, amount, destination_account, destination_bank)
    # TODO: make this validation simpler and more compartamentalized
    raise Api::V1::InvalidAmountException, 'Amount must be positive' unless amount.positive?
    unless ClabeAccount.validate_clabe(source_account)
      raise Api::V1::InvalidClabeException, 'Invalid CLABE for source account'
    end
    unless ClabeAccount.validate_clabe(destination_account)
      raise Api::V1::InvalidClabeException, 'Invalid CLABE for destination account'
    end

    clabe_account = ClabeAccount.get_clabe_account(destination_account)
    # puts "#{destination_account} CLABE ACCOUNT -> #{clabe_account.as_json} vs #{destination_bank}"
    if clabe_account.nil? || clabe_account.short_name != destination_bank
      raise Api::V1::InvalidClabeException, 'Invalid ABM code or bank short name for CLABE destination account'
    end

    account = checking_accounts.where(clabe: source_account).first
    return if account.nil? ## probably handle some exception here
    account.do_withdraw(amount, destination_account)
  end

  ##
  # Deposits a certain amount to the account
  def do_deposit(account_number, amount)
    raise Api::V1::InvalidAmountException, 'Amount must be positive' unless amount.positive?

    account = checking_accounts.where(clabe: account_number).first
    return if account.nil? ## probably handle some exception here

    account.do_deposit(amount)
  end
end
