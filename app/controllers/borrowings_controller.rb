class BorrowingsController < ApplicationController
  
  before_action :logged_in_user
  
  def new
    @borrowing = Borrowing.new
  end
  
  def show
  end
  
  def index
  end
  
  require 'date'
  def create
    # binding.pry
    @item = Item.find(params[:borrowed_item])
    @item_start = @item.start_day
    @item_end = @item.end_day
    @item_borrow_start = params[:start_day]
    @item_borrow_end = params[:end_day]
    
    # @item_start = Date.parse(@item.start_day)
    # @item_end = Date.parse(@item.end_day)
    # @item_borrow_start = Date.parse(params[:start_day])
    # @item_borrow_end = Date.parse(params[:end_day])
    
    # binding.pry
    start_day_validate = Date.parse(@item_borrow_start) - @item_start
    end_day_validate = @item_end - Date.parse(@item_borrow_end)
    
    # start_day_validate = @item_borrow_start - @item_start
    # end_day_validate = @item_end - @item_borrow_end
    
    day = 0
    if start_day_validate >= day && end_day_validate >= day
    # binding.pry
    # current_user.borrow(@item)
    current_user.borrowed_items.create(borrowed_item_id: @item.id, start_day: @item_borrow_start, end_day: @item_borrow_end )
    # current_user.borrowed_items.create(borrowed_item_id: @item.id)
    redirect_to item_path(@item)
    else
    flash[:danger] = "有効な利用期間が設定されていません。"
    redirect_to item_path(@item)
    # redirect_to item_path(@item), alert: '有効な利用期間が設定されていません。'
    end
  end
  
  # def create
  #   @item = current_user.items.build(item_params)
  #   if @item.save
  #     flash[:success] = "アイテムは保存されました。"
  #     redirect_to current_user
  #   else
  #     render 'top_pages/home'
  #   end
  # end
  
  def update
    
  end
  
  def destroy
    # binding.pry
    @item = current_user.borrowed_items.find(params[:id]).borrowed_item
    current_user.item_return(@item)
    redirect_to item_path(@item)
  end
  
  def edit
  end
  
  private
  def borrowing_params
    params.require(:borrowing).permit(:borrower, :borrowed_item, :start_day, :end_day)
  end
  
end
