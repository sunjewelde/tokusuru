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
    has_many :borrowing_items, through: :borrowed_items, source: :borrowed_item
end
