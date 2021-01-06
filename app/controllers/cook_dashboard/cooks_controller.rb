class CookDashboard::CooksController < ApplicationController
  def show
    @user = current_user
    @cook = current_user.cook
  end

  def update
    cook_details = params.require(:cook).permit(:first_name, :last_name, :description)
    current_user.cook.update(cook_details)
    redirect_back(fallback_location: homepage_path)
  end
end
