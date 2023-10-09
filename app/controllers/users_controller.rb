class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  #before_action:コントローラーで各アクションを実行する前に実行したい処理を指定することができるメソッド
  
  def new
  end
  


  def index
    @users = User.all
    @newbook = Book.new # 空のインスタンス
    @user = current_user
  
    if user_signed_in? # ユーザーがログインしている場合
      # ログインメッセージを表示
      flash[:notice] = 'Welcome! You have signed up successfully.'
    else
      redirect_to root_path # ユーザーがログインしていない場合はTopページにリダイレクト
    end
  end

  def show
   @user = User.find(params[:id])

    @profile_image = @user.profile_image
    @newbook =Book.new#空のインスタ
    @books = @user.books  
    #@post_images = @user.post_images.page(params[:page])
  end


  def edit
    @user = User.find(params[:id])
    #redirect_to books_path
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
    session[:user_id] = nil
    redirect_to root_path
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
   
  def is_matching_login_user
    #user_id = params[:id]
    @user = User.find(params[:id])
    #login_user_id = current_user.id
    if(@user != current_user)
      redirect_to user_path(current_user)
    end
  end
  
end
