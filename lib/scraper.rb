require 'open-uri'
require 'nokogiri'

def scrape(keyword)
  url = "https://letsy.lewagon.com/products?search=#{keyword}"
  # 1. We get the HTML page content
  html_content = URI.parse(url).read
  # 2. We build a Nokogiri document from this file
  doc = Nokogiri::HTML.parse(html_content)

  letsy_gifts = {
    # gift_name => false
  }
  # 3. We search for the correct elements containing the items' title in our HTML doc
  doc.search('.title').first(4).each do |element|
    # 4. For each item found, we extract its title and print it

    # gift = element.text.strip
    # HASH CRUD create
    letsy_gifts[element.text.strip] = false
  end
  letsy_gifts
end

# p scrape("scarf")

# make a method with the scraper
# pass the keyword to the method
# interpolate the keyword in the url
# return a hash that looks like the gift_list but instead with the gifts from letsy

# doc.search('h2') # html element 
# doc.search('.red') # css class 
# doc.search('#title') # css id 
# doc.search('.title-container .price') # with a space we look for a class inside of the first class 
# doc.search('.title-container.price') # with no space we look for an html element with both classes
