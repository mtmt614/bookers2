class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    user_id = params[:id].to_i
    login_user_id = current_user.id
  if(user_id != login_user_id)
    redirect_to user_path(current_user.id)
  end
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    flash[:notice] = "Welcome! You have signed up successfully."
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user.id)
    else
        render:edit
    end
  end

   private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user
      user_id = params[:id].to_i
      login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_path(current_user.id)
    end
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless @user == current_user
  end
end
