class Item < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, length: { maximum: 250 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :category, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  
end
