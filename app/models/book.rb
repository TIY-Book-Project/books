class Book < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by'
  has_many :recommendations
  has_many :reviews
  has_and_belongs_to_many :book_shelves

  validates_presence_of :title, :author, :isbn, :description, :image_url

end
