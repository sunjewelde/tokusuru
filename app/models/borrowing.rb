class Borrowing < ActiveRecord::Base
  belongs_to :borrower, class_name: "User"
  belongs_to :borrowed_item, class_name: "Item"
  validates :start_day, presence: true
  validates :end_day, presence: true
  
  # validates :start_day, presence: true
  # validates :end_day, presence: true
  
  
end
