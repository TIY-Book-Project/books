json.array! @books do |book|
  json.(book, :id, :title, :author, :isbn, :description, :image_url)
end
