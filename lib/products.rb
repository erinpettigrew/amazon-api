class Product

  attr_accessor :brand, :name, :price, :url, :image, :asin

  # transform API response into a Ruby object, Product
  def self.new_from_hash(item_hash)
    new_product = Product.new
    new_product.brand = item_hash["ItemAttributes"]["Brand"]
    new_product.name = item_hash["ItemAttributes"]["Title"]
    new_product.price = item_hash["OfferSummary"]["LowestNewPrice"]["FormattedPrice"]
    new_product.url = item_hash["DetailPageURL"]
    new_product.image = item_hash["LargeImage"]["URL"]
    new_product.asin = item_hash["ASIN"]
    new_product
  end

  # display the product
  def display
    puts brand
    puts name
    puts price
    puts url
    puts asin
    puts image
  end

end
