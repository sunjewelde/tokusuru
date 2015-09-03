class Item < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, length: { maximum: 250 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :category, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  
  has_one :borrower_user, class_name: "Borrowing", foreign_key: "borrowed_item", dependent: :destroy
  has_one :borrowing_user, through: :borrower_user, source: :borrower
  
end
