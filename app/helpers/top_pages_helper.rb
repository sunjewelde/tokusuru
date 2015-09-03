module TopPagesHelper
  def home
    @item = current_user.items.build if logged_in?
  end
end
