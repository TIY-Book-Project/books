class CreateBookShelves < ActiveRecord::Migration
  def change
    create_table :book_shelves do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end
