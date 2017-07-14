require_relative "../config/environment.rb"


keywords = "harry potter chamber of secrets"
category = "Books"
asin = "B000PVPEFU"


# ------


puts "\n\n\nsearch by keyword: #{keywords}\n"
# make request to Amazon API
search = AmazonAPI.new
url = search.by_keyword(keywords)
results = HTTParty.get(url)

# get first matching item
first_matching_item_hash = results["ItemSearchResponse"]["Items"]["Item"].first
matching_product = Product.new_from_hash(first_matching_item_hash)

# display item's attributes
matching_product.display


# ------


puts "\n\n\nsearch by ASIN: #{asin}\n"

search = AmazonAPI.new
url = search.by_asin(asin)
results = HTTParty.get(url)

# get first matching item
first_matching_item_hash = results["ItemLookupResponse"]["Items"]["Item"]

matching_product = Product.new_from_hash(first_matching_item_hash)

# display item's attributes
matching_product.display
puts results


# ------


puts "\n\n\nsearch by keyword and category: #{keywords}, #{category}\n"

# make request to Amazon API
search = AmazonAPI.new
url = search.by_keyword_and_category(keywords, category)
results = HTTParty.get(url)

# get first matching item
first_matching_item_hash = results["ItemSearchResponse"]["Items"]["Item"].first
matching_product = Product.new_from_hash(first_matching_item_hash)

# display item's attributes
matching_product.display


# ------


puts "\n\n\nsearch by ASIN for similar items: #{asin}\n"

# make request to Amazon API
search = AmazonAPI.new
url = search.by_asin_for_similar_items(asin)

results = HTTParty.get(url)

# get matching items
matching_items_array = results["SimilarityLookupResponse"]["Items"]["Item"]

# create product objects
matching_products = []
matching_items_array.each do |item_hash|
  match = Product.new_from_hash(item_hash)
  matching_products << match
end

# display all products' attributes
matching_products.each do |product|
  product.display
end
