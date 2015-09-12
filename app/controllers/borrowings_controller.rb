class BorrowingsController < ApplicationController
  before_action :logged_in_user
  
  def new
    @borrowing = Borrowing.new
  end
  
  def show
  end
  
  def index
  end
  
  def create
    # binding.pry
    @item = Item.find(params[:borrowed_item])
    current_user.borrow(@item)
    # render 'new'
    redirect_to item_path(@item)
  end
  
  def update
    
  end
  
  def destroy
    @item = current_user.borrowed_items.find(params[:id]).borrowed_item
    current_user.item_return(@item)
    redirect_to item_path(@item)
  end
  
  def edit
  end
  
  private
  def borrowing_params
    params.require(:borrowing).permit(:borrower, :borrowed_item)
  end
  
end
