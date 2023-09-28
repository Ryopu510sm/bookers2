class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  #before_action:コントローラーで各アクションを実行する前に実行したい処理を指定することができるメソッド

  
  def create
    @user = current_user
    @newbook = Book.new(book_params)
    @newbook.user_id = @user.id
    @newbook.save
    
       # if @newbook.save
           # flash[:notice] = "Book was successfully created."
            redirect_to book_path(@newbook)
      #  else
           # flash[:notice] = "Failed to post."
           # @books = Book.all
           # render :index
       # end 
  end

  def index
    @newbook =Book.new#空のインスタ
    @books = Book.all
    
    @user = current_user
   #@user_images = @user.user_images
   @user_images = [] # 空の配列
    @user.profile_image.attach(params[:profile_image]) if params[:profile_image].present?
    redirect_to edit_user_path(@user), notice: 'ユーザーアイコンが更新されました'
  
   
   

  # ユーザーの画像データを取得して @user_images に追加する例
  profile_image_data = @user.get_profile_images(100, 100) # 100x100 サイズのプロフィール画像データを取得
  @user_images << profile_image_data
    
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    #@book = Book.find(params[:id])#データ１件取得
    @book.user_id = @user.id
  end
  
  def edit
    @book = Book.find(params[:id])#データ１件取得
  end
  

  def destroy
  end
  
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end 
end
