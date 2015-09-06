class ItemsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  
  def index
    # itemを全て取得する。
    @items = Item.all
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
      redirect_to root_url
    else
      render 'top_pages/home'
    end
  end
  
  def destroy
    @item = current_user.items.find_by(id: params[:id])
    return redirect_to root_url if @item.nil?
    @item.destroy
    flash[:success] = "アイテムは削除されました。"
    redirect_to request.referrer || root_url
  end
  
  
  def update
    @item = current_user.items.find_by(id: params[:id])
    if @item.update(update_params)
      redirect_to root_path , notice: 'アイテム情報を編集しました。'
    else
      render 'edit'
    end
  end
  
  def edit
    @item = current_user.items.find_by(id: params[:id])
    # @item = Item.find(params[:id])
  end
  

  
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
                                 {avatars: []})
  end
  
  def update_params
  params.require(:item).permit(:title, :description, :category, :start_day, :end_day, :content, {avatars: []})
  end
  
end
