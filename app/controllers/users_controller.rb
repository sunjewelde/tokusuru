class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
     @user = User.find(params[:id])
    # @items = @user.items
     @items = @user.items.page(params[:page])
     @borrowings = @user.borrowed_items
  end

  
  def show_borrowing
    user_id = current_user.id
    @user = User.find(user_id)
    @items = @user.items
    @borrowings = @user.borrowed_items
  end

  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to TOKUSURU! ユーザー登録が完了しました。"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path , notice: 'ユーザー情報を編集しました。'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
