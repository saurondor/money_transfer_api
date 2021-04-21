require 'exceptions'
class Api::V1::MoneyTransferController < ApplicationController
  before_action :authenticate_user!

  before_action :require_admin, except: [:transfer]

  def require_admin
    render json: {"message" => "User is not ADMIN"}, status: :unauthorized unless current_user.is_admin?
  end

  def index
  end

  def show
  end

  ##
  #  Transfers money from user checking account to third party account identified by CLABE
  #
  #  **POST** /api/v1/transfer
  #
  #
  # Outbound operation of funds from checking account
  #
  # Transfers funds to account identified by CLABE account number
  #
  # @param [String] clabe, CLABE account identifier
  #
  # @param [Float] amount, amount to add to account
  #
  def transfer
    source_account = params['operation']['source_account']
    destination_account = params['operation']['destination_account']
    destination_bank = params['operation']['destination_bank']
    amount = params['operation']['amount'].to_f
    begin
      current_user.do_withdraw(source_account, amount, destination_account, destination_bank)
    rescue Api::V1::InvalidAmountException => e
    rescue Api::V1::InvalidBalanceException => e
    rescue Api::V1::InvalidClabeException => e

    end

  end

  ##
  #  Creates a deposit to a user checking account
  #
  #  **POST** /api/v1/add_funds
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
