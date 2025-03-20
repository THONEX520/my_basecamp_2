class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy, :set_admin, :remove_admin]

  def index
    @users = User.all
  end

  def show
    respond_to do |format|
      format.html { render :show }
    end
  end

  def set_admin
    @user = User.find(params[:id]) # Find the user by ID
    @user.add_role(:admin) # Assign the admin role
    redirect_to users_path, notice: "#{@user.email} is now an Admin." # Redirect to the users list
  end

  def remove_admin
    @user.remove_role(:admin)
    redirect_to admin_users_path, notice: "#{@user.email} is no longer an Admin."
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully."
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_admin
    redirect_to root_path, alert: "Not authorized!" unless current_user.has_role?(:admin)
  end
end
