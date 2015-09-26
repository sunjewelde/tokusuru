class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  

    
    has_many :items
    has_many :borrowed_items, class_name: "Borrowing", foreign_key: "borrower_id", dependent: :destroy
    # has_many :borrowing_items, through: :borrowed_items, source: :item
    # has_many :borrowed_items, class_name: "Borrowing", foreign_key: "borrower_id", dependent: :destroy
    has_many :borrowing_items, through: :borrowed_items, source: :borrowed_item
    
  # アイテムを借りる
   def borrow(item)
    # borrowed_items.create(borrower_id: item.id)
    borrowed_items.create(borrowed_item_id: item.id)
    # borrowed_items.create(borrowed_item_id: item.id, start_day: date, end_day: date)
    # borrowed_items.create([{borrowed_item_id: item.id}, {start_day: date}, {end_day: date}])
   end
  
  # アイテムを返却する
  def item_return(item)
     borrowed_items.find_by(borrowed_item_id: item.id).destroy
  end
   
    # アイテムを借りているかどうか？
  def borrowing?(item)
    borrowing_items.include?(item)
  end
  
     #自分のアイテムかどうか？
#   def own_item(item)
#     current_user_items.include?(item)
#   end
  

end
