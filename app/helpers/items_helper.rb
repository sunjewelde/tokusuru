module ItemsHelper
#     def current_user
#     @current_user ||= User.find_by(id: session[:user_id])
#   end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
  
    def index
    # itemを全て取得する。
    @items = Item.all
    end
  
  
end
