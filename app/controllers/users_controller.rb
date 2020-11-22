class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update_details
    user_details = params.require(:user).permit(:first_name, :last_name, :email, :phone_number)
    User.find(params[:id]).update(user_details)
    redirect_to user_path
  end

  def update_address
    user_address = params.require(:user).permit(:address, :city, :zip)
    User.find(params[:id]).update(user_address)
    redirect_to user_path
  end
end
