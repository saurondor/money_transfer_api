class Api::V1::UserController < ApplicationController
  before_action :authenticate_user!

  before_action :require_admin, :except => []

  def require_admin
    render json: {"message" => "User is not ADMIN"}, status: :unauthorized unless current_user.is_admin?
  end

  def index
  end

  def show
  end

  ##
  # Should allow an admin user to create a holder user account
  # Returns 422 unprocessable entity if user was not created
  def create
    clabe = params['user']['clabe']
    email = params['user']['email']
    begin
      user = User.create!(
          email: email,
          role: User::ROLE_HOLDER,
          password: params['user']['password']
      )
      checking_account = CheckingAccount.create(
                                            user: user,
                                            clabe: clabe
      )
      render body: nil, status: :created
    rescue => e
      puts "#{e.message}"
      render json: {"message" => e.message}, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end
end
