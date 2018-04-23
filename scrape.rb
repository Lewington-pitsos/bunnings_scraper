require 'watir'
require 'nokogiri'



# the root url from which the scrape starts
root = 'https://www.bunnings.com.au/search/products?facets=CategoryIdPath%3D2a021706-07d5-4648-bf26-2ea8fea049df%20%3E%20bfa7e4dc-1acd-4499-819c-12c0c7dea779%20%3E%20aeffcfe3-92c3-4f35-b206-64ecc6243255%20%3E%209e158173-ddc0-44fd-92d1-b2496c222b78'

PRICE_XPATH = '//div[@class="price-value"]/text()'

BUTTON_CLASSES = ['next', 'view-more']

# if you load a ruby file, all the constants get added to the global scope, so to set up our real time scrape we just load this file in irb
BR = Watir::Browser.new :firefox
BR.goto(root)

def xml_page
  page = BR.html
  Nokogiri::HTML(page)
end

# INPUT: an array of classes
# DOES: keeps clicking on the element with those classes untill we get an error
# OUTPUT: n/a
def keep_clicking(classes)
  while true
    begin
      BR.link(:class => classes).click()
    rescue
      break
    end
  end
end

# INPUT: a Nokogiri XML object representing the current page
# DOES: finds every price of every item on that page and works out the average price
# OUTPUT: the average price
def get_all_prices(page)
  total = 0
  doors = page.xpath(PRICE_XPATH)

  doors.each do |price|
    value = price.text.to_i
    total += value
  end

  total/doors.size
end
