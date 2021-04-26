%w[
  Categories
  Creators
].each do |tag_category_name|
  TagCategory.find_or_create_by(name: tag_category_name)
end
