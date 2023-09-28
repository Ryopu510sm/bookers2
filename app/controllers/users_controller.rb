class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  #before_action:コントローラーで各アクションを実行する前に実行したい処理を指定することができるメソッド
  
  def new
  end

  #def index
    #@user = User.find(params[:user_id])
    
  #end

  #def show
   # @user = User.find(params[:user_id])

    #@profile_images = @user.profile_images 
    #@books = @user.books  
    #@post_images = @user.post_images.page(params[:page])
  #end
  
  def show
    redirect_to books_path
  end


  

  def edit
    @user = User.find(params[:id])
    redirect_to books_path
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "You have updated user successfully."
      render :edit
    end
  end


  def destroy
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
   
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
  
  
end
