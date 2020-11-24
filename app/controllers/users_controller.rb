class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update_details
    user_details = params.require(:user)
                         .permit(:first_name,
                                 :last_name,
                                 :email,
                                 :phone_number,
                                 :address,
                                 :city,
                                 :zip,
                                 :digicode,
                                 :flat_number)

    User.find(params[:id]).update(user_details)
    redirect_back(fallback_location: homepage_path)
  end
end
