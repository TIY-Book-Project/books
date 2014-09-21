class CreateBookShelvesBooks < ActiveRecord::Migration
  def change
    create_table :book_shelves_books, :id => false do |t|
      t.references :book_shelf
      t.references :book
    end
  end
end
