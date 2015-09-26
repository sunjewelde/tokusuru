class ItemsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update]
  
  def index
    # itemを全て取得する。
    # @items = Item.all
    @items = Item.page(params[:page])
  end

  def find_borrowing
    #For ransack
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end
  
  def found_item
    # @items = Item.search(params[:search])
    
    # Pagenatey用
    # @found_items = Item.search(params[:search])
    # @items = @found_items.page(params[:page])
    
    # For ransack
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end
  
  def show
    @item = Item.find_by(id: params[:id])
    user_id = @item.user_id
    @user = User.find(user_id)
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "アイテムは保存されました。"
      redirect_to current_user
    else
      render 'top_pages/home'
    end
  end
  
  # def reserve
  #   @item = Item.find_by(id: params[:id])
  # end
  
  def destroy
    @item = current_user.items.find_by(id: params[:id])
    return redirect_to current_user_path if @item.nil?
    @item.destroy
    flash[:success] = "アイテムは削除されました。"
    redirect_to request.referrer || root_url
  end
  
  
  def update
    @item = current_user.items.find_by(id: params[:id])
    if @item.update(update_params)
      redirect_to current_user , notice: 'アイテム情報を編集しました。'
    else
      render 'edit'
    end
  end
  
  def edit
    @item = current_user.items.find_by(id: params[:id])
    # @item = Item.find(params[:id])
  end
  

  # def logged_in_user
  #   unless logged_in?
  #     flash[:danger] = "ログインして下さい。"
  #     redirect_to login
  #   end
  # end
  
  # def image_upload
  #   params.require(:item).permit(:title, :description, :category, :start_day, :end_day, :content, {avatars: []})
  # end

  
  private
  def item_params
    params.require(:item).permit(:title,
                                 :description, 
                                 :category, 
                                 :content, 
                                 :start_day, 
                                 :end_day, 
                                 :small_image, 
                                 :medium_image, 
                                 :large_image,
                                 :avatar)
  end
  
  def update_params
  params.require(:item).permit(:title, :description, :category, :start_day, :end_day, :content, :avatar)
  end
  
end
