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
  
  require 'date'
  def found_item
    if params[:q][:start_day] != nil and params[:q][:end_day] != nil and params[:q][:category] != nil and  params[:q][:title_cont] != nil
      title = params[:q][:title_cont]
      category = params[:q][:category]
      start_day_s = params[:q][:start_day]
        if start_day_s != ""
        start_day = Date.parse(start_day_s)
        end
      end_day_s = params[:q][:end_day]
        if end_day_s != ""
        end_day = Date.parse(end_day_s)
        end
      
      if category != "" && start_day_s == "" && end_day_s == ""
        @i = Item.where(:category => category )
        @items = @i.search(:title_cont => title).result.page(params[:page])
      elsif category == "" && start_day_s != "" && end_day_s != ""
        @items = Item.search(:start_day_lteq => start_day, :end_day_gteq => end_day).result.page(params[:page])
        # @items_start = Item.search(:start_day_lteq => start_day).result
        # @items = @items_start.search(:end_day_gteq => end_day).result.page(params[:page])
      elsif category != "" && start_day_s != "" && end_day_s != ""
        # @items = Item.search(:category => category, :start_day_lteq => start_day, :end_day_gteq => end_day).result.page(params[:page])
        @i = Item.where(:category => category )
        @items_start = @i.search(:start_day_lteq => start_day).result
        @items = @items_start.search(:end_day_gteq => end_day).result.page(params[:page])
      else
        @items = Item.search(:title_cont => title).result.page(params[:page])
      end
    else
      @q = Item.ransack(params[:q])
      @items = @q.result(distinct: true)
      @items = @q.result(distinct: true).page(params[:page])
    end
    
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
    @q = Item.ransack(params[:q])
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
    ct = params[:category]
    if ct == "c1"
       @category = "家電、カメラ、AV機器"
      elsif ct == "c2"
       @category = "パソコン・オフィス用品"
      elsif ct == "c3"
       @category = "ホーム＆キッチン・ペット・DIY"
      elsif ct == "c4"
       @category = "ヘルス＆ビューティー"
      elsif ct == "c5"
       @category = "ベビー・おもちゃ・ホビー"
      elsif ct == "c6"
       @category = "ファッション・バッグ・腕時計"
      elsif ct == "c7"
       @category = "スポーツ＆アウトド"
      else
       @category = "車＆バイク・産業・研究開発"
    end
      
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
