class ItemsController < ApplicationController
  before_action :logged_in_user, only: [:create]

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
                                 :large_image)
  end
end
