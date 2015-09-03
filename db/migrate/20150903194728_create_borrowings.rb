class CreateBorrowings < ActiveRecord::Migration
  def change
    create_table :borrowings do |t|
      t.references :borrower, index: true, foreign_key: true
      t.references :borrowed_item, index: true, foreign_key: true

      t.timestamps null: false
      t.index [:borrowed_item_id, :borrower_id], unique: true
    end
  end
end
