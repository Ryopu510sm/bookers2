class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  #before_action :authenticate_user!, only: [:edit, :update, :destroy]
  #before_action:コントローラーで各アクションを実行する前に実行したい処理を指定することができるメソッド

  
  def create # 投稿データの保存
    @user = current_user
    @newbook = Book.new(book_params)
    @newbook.user_id = @user.id
    @newbook.save
    
      if @newbook.save
           flash[:notice] = "Book was successfully created."
            redirect_to book_path(@newbook)
      else
           flash[:notice] = "Failed to post."
           @books = Book.all
           render :index
      end 
  end

  def index
    if user_signed_in?
        @newbook =Book.new#空のインスタ
        @books = Book.all
        
        @user = current_user
       #@user_images = @user.user_images
       @user_images = [] # 空の配列
        @user.profile_image.attach(params[:profile_image]) if params[:profile_image].present?
        #redirect_to edit_user_path(@user), notice: 'ユーザーアイコンが更新されました'
    
      # ユーザーの画像データを取得して @user_images に追加する例
      profile_image_data = @user.get_profile_images(100, 100) # 100x100 サイズのプロフィール画像データを取得
      @user_images << profile_image_data
    else
      redirect_to root_path
    end
    
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    #@book = Book.find(params[:id])#データ１件取得
   
    @newbook =Book.new#空のインスタ
  end
  
  def edit
    @book = Book.find(params[:id])#データ１件取得
  end
  
  def update
    @book = Book.find(params[:id])
  
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully.。"
    else
      flash[:notice] = "Failed to post."
      render :edit # 更新に失敗した場合は編集画面を再表示
    end
  end

  

  def destroy
    @book = Book.find(params[:id])#削除するレコードを取得
    @book.destroy#削除
    redirect_to '/books'#一覧ページへのパス
  end
  
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body, :name)
  end 
  
end
