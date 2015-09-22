class AddDateToBorrowings < ActiveRecord::Migration
  def change
    add_column :borrowings, :start_day, :date
    add_column :borrowings, :end_day, :date
  end
end
