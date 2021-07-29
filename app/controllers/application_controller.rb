class ApplicationController < ActionController::Base
    before_action :authenticate_user!,except: [:top, :show]

    before_action :configure_permitted_parameters, if: :devise_controller?






  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end





    def after_sign_in_path_for(resource)
    books_path
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
