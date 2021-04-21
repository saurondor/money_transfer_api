class Api::V1::MoneyTransferController < Api::V1::BaseApiController
#  before_action :authenticate_user!

  before_action :require_admin, except: [:transfer]

  # def require_admin
  #   render json: {"message" => "User is not ADMIN"}, status: :unauthorized unless current_user.admin?
  # end

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
      auth_code = current_user.do_withdraw(source_account, amount, destination_account, destination_bank)
      render json: { :auth_code => auth_code }, :status => :created
    rescue Api::V1::InvalidAmountException => e
      render json: { :message => e.message }, :status => :bad_request
    rescue Api::V1::InvalidBalanceException => e
          render json: { :message => e.message }, :status => :bad_request
    rescue Api::V1::InvalidClabeException => e
      render json: { :message => e.message }, :status => :bad_request
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
    #puts "Adding funds #{email} -> #{user.as_json}"

    if user.nil?
      render json: {"message" => "No such user"}, :status => :bad_request
      return
    end
    #raise InvalidUserAccountException.new "Specified user does not exist" unless !user.nil?
    begin
      auth_code = user.do_deposit(clabe, amount)
      render json: {"auth_code" => auth_code}, :status => :created
    rescue Api::V1::InvalidAmountException => e
      render json: {"message" => e.message}, :status => :bad_request
    rescue Api::V1::InvalidBalanceException => e
      render json: {"message" => e.message}, :status => :bad_request
    rescue Api::V1::InvalidClabeException => e
      render json: {"message" => e.message}, :status => :bad_request
    end
  end

  def create
  end

  def update
  end

  def destroy
  end
end
