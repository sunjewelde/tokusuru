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
    # @items = @q.result(distinct: true)
    @items = @q.result(distinct: true).page(params[:page])
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
  
  def item_ranking
    @items = Item.all
    hot_item = Item.group(:title).order('count_title desc').limit(10).count(:title).keys
    @ranking = Item.where(title: hot_item).sort_by {|i| hot_item.index(i.title)}
  end
  
  def item_borrower_ranking
    # @items = Borrowing.all
    item_key = Borrowing.group(:borrowed_item_id).order('count_borrowed_item_id desc').count(:borrowed_item_id).keys
    # binding.pry
    hot_item  = Item.where(id: item_key).group(:title).order('count_title desc').limit(10).count(:title).keys
    @ranking =Item.where(title: hot_item).sort_by {|i| hot_item.index(i.title)}
  end
  
  def item_category
    #itemカテゴリーを取得
    @items = Item.where(category: params[:category]).page(params[:page])
    #itemをカテゴリーでソート
  end
  
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
