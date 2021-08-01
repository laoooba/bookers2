class ApplicationController < ActionController::Base
    before_action :authenticate_user!,except: [:top, :show]

    before_action :configure_permitted_parameters, if: :devise_controller?






  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
   redirect_back(fallback_location: root_path)
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    redirect_back(fallback_location: root_path)
  end





    def after_sign_in_path_for(resource)
    books_path
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
