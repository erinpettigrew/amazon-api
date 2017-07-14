class AmazonAPI

  ENDPOINT = "webservices.amazon.com"
  REQUEST_URI = "/onca/xml"


  def by_asin(asin)
    params = {
      "Service" => "AWSECommerceService",
      "Operation" => "ItemLookup",
      "AWSAccessKeyId" => KEYS["AWS_ACCESS_KEY_ID"],
      "AssociateTag" => KEYS["AWS_ASSOCIATES_TAG"],
      "ItemId" => asin,
      "IdType" => "ASIN",
      "ResponseGroup" => "Images,Offers,Small,ItemAttributes,Large",
      "Condition" => "New"
    }
    generate_request_url(params)
  end

  def by_keyword(keywords)
    params = {
      "Service" => "AWSECommerceService",
      "Operation" => "ItemSearch",
      "AWSAccessKeyId" => KEYS["AWS_ACCESS_KEY_ID"],
      "AssociateTag" => KEYS["AWS_ASSOCIATES_TAG"],
      "SearchIndex" => "All",
      "Keywords" => keywords,
      "ResponseGroup" => "Images,Offers,Small"
    }
    generate_request_url(params)
  end

  def by_keyword_and_category(keywords, category)
    params = {
      "Service" => "AWSECommerceService",
      "Operation" => "ItemSearch",
      "AWSAccessKeyId" => KEYS["AWS_ACCESS_KEY_ID"],
      "AssociateTag" => KEYS["AWS_ASSOCIATES_TAG"],
      "SearchIndex" => category,
      "Keywords" => keywords,
      "ResponseGroup" => "Images,Offers,Small"
    }
    generate_request_url(params)
  end

  def by_asin_for_similar_items(asin)
    params = {
      "Service" => "AWSECommerceService",
      "Operation" => "SimilarityLookup",
      "AWSAccessKeyId" => KEYS["AWS_ACCESS_KEY_ID"],
      "AssociateTag" => KEYS["AWS_ASSOCIATES_TAG"],
      "ItemId" => asin,
      "MerchantId" => "Amazon",
      "ResponseGroup" => "Images,Offers,Small",
      "SimilarityType" => "Intersection"
    }
    generate_request_url(params)
  end

  def generate_request_url(params)
    params["Timestamp"] = Time.now.gmtime.iso8601 if !params.key?("Timestamp")
    canonical_query_string = params.sort.collect do |key, value|
      [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=')
    end.join('&')
    string_to_sign = "GET\n#{ENDPOINT}\n#{REQUEST_URI}\n#{canonical_query_string}"
    signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), KEYS["AWS_SECRET_KEY"], string_to_sign)).strip()
    request_url = "http://#{ENDPOINT}#{REQUEST_URI}?#{canonical_query_string}&Signature=#{URI.escape(signature, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"
  end

  def make_request
    search = AmazonAPI.new
    url = search.by_keyword(keywords)
    results = HTTParty.get(url)
  end

  def parse_results
    first_matching_item_hash = results["ItemSearchResponse"]["Items"]["Item"].first
    matching_product = Product.new_from_hash(first_matching_item_hash)
  end

end
