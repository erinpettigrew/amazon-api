# Assuming API response is stored in a hash called results
# You can retrieve from results an array of hashes where each hash is an item using the below

results["ItemSearchResponse"]["Items"]["Item"] #=> array of item hashes

# Inside each array element is an item hash, assumed here to be a hash object called item_hash
# Here are hash iterations for major product attributes within item_hash

# ASIN
item_hash["ASIN"]

# URL
item_hash["DetailPageURL"]

# Sales rank
item_hash["SalesRank"]

# Small image thumb URL
item_hash["SmallImage"]["URL"]

# Medium image thumb URL
item_hash["MediumImage"]["URL"]

# Large image thumb URL
item_hash["LargeImage"]["URL"]

# Brand
item_hash["ItemAttributes"]["Brand"]

# Product title
item_hash["ItemAttributes"]["Title"]

# UPC
item_hash["ItemAttributes"]["UPC"]

# Lowest new price, formatted as string e.g. "$15.00"
item_hash["OfferSummary"]["LowestNewPrice"]["FormattedPrice"]

# Lowest new price, formatted as integer in cents e.g. 1500
item_hash["OfferSummary"]["LowestNewPrice"]["Amount"]

# Description, usually from manufacturer
item_hash["EditorialReviews"]["EditorialReview"]["Content"]