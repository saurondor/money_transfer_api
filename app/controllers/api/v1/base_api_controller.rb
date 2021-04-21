class Api::V1::BaseApiController < ApplicationController
  before_action :authenticate_user!

  def require_admin
    render json: {"message" => "User is not ADMIN"}, status: :unauthorized unless current_user.admin?
  end

end
