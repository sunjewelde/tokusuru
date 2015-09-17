class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      # t.references :user, index: true, foreign_key: true
      t.references :user, index: true
      t.string :title
      t.string :description
      t.string :category
      t.string :detail_page_url
      t.string :small_image
      t.string :medium_image
      t.string :large_image
      t.text :content
      t.date :start_day
      t.date :end_day

      t.timestamps null: false
      t.index [:user_id, :created_at]
    end
  end
end
