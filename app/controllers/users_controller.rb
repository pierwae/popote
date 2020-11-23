class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update_details
    user_details = params.require(:user).permit(:first_name, :last_name, :email, :phone_number)
    User.find(params[:id]).update(user_details)
    redirect_to account_path
  end

  def update_address
    user_address = params.require(:user).permit(:address, :city, :zip)
    User.find(params[:id]).update(user_address)
    redirect_to account_path
  end

  def update_details_from_basket_show
    user_address = params.require(:user).permit(:address, :city, :zip, :digicode, :flat_number, :phone_number)
    User.find(params[:id]).update(user_address)
    basket = Basket.find(params[:baskets_id])
    redirect_to basket_path(basket)
  end
end
