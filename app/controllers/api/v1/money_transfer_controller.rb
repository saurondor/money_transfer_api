require 'exceptions'
class Api::V1::MoneyTransferController < ApplicationController
  before_action :authenticate_user!

  before_action :require_admin, except: [:transfer]

  def require_admin
    puts "USER IS #{current_user.role}"
    render json: {"message" => "User is not ADMIN"}, status: :unauthorized unless current_user.is_admin?
  end

  def index
  end

  def show
  end

  ##
  # Creates a CLABE transfer
  # Outbound operation of funds from checking account
  # parameters
  # USER - from login
  # amount
  # clabe account
  #
  # ?? return values
  # OK - Created
  # invalid operation - invalid CLABE
  #
  def transfer

  end

  ##
  #  Creates a deposit to a user checking account
  #
  #  **GET** /api/v1/pets
  #
  #
  # Inbound operation of funds to checking account
  #
  # Adds funds to account identified by CLABE account number
  #
  # @param [String] clabe, CLABE account identifier
  #
  # @param [String] email, email identifing user
  #
  # @param [Float] amount, amount to add to account
  #
  def add_funds
    email = params['user']['email']
    clabe = params['user']['clabe']
    amount = params['user']['amount'].to_f
    user = User.where(:email => email).first
    puts "Adding funds #{email} -> #{user.as_json}"
    #raise InvalidUserAccountException.new "Specified user does not exist" unless !user.nil?
    begin
      user.do_deposit(clabe, amount)
    rescue Api::V1::InvalidAmountException => e
    rescue Api::V1::InvalidBalanceException => e
    rescue Api::V1::InvalidClabeException => e

    end
  end

  def create
  end

  def update
  end

  def destroy
  end
end
