require 'carrierwave/orm/activerecord'
#require 'file_size_validator'

class Item < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  #mount_uploaders :avatars, AvatarUploader
  belongs_to :user
  validates :user_id, presence: true
  validates :content, length: { maximum: 250 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :category, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  
  has_one :borrower_user, class_name: "Borrowing", foreign_key: "borrowed_item_id", dependent: :destroy
  # has_one :borrowing_user, through: :borower_user, source: :user
  
  # has_one :borrower_user, class_name: "Borrowing", foreign_key: "borrowed_item_id", dependent: :destroy
  has_one :borrowing_user, through: :borower_user, source: :borrower
  
  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Item.where(['title LIKE ?', "%#{search}%"])
    else
      flash[:danger] = "アイテムは見つかりませんでした。"
      Item.all #全て表示。
    end
  end
  

end
