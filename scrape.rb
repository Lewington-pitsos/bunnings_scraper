require 'watir'
require 'nokogiri'



# the root url from which the scrape starts
root = 'https://www.bunnings.com.au/our-range/building-hardware/building-construction/doors'

category_selector  =

# if you load a ruby file, all the constants get added to the global scope, so to set up our real time scrape we just load this file in irb
BR = Watir::Browser.new :firefox
BR.goto(root)

def xml_page
  page = BR.html
  Nokogiri::HTML(page)
end
