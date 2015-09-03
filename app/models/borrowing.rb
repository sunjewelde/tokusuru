class Borrowing < ActiveRecord::Base
  belongs_to :borrower, class_name: "User"
  belongs_to :borrowed_item, class_name: "Item"
end
