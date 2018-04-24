require 'watir'

BR = Watir::Browser.new :firefox
BR.goto('https://www.bunnings.com.au/our-range/kitchen/benchtops/stone')

CLASSES = ['next', 'view-more']
PRICE_CLASS = 'price-value'

def keep_clicking(classes)
  while true
    begin
      BR.link(:class => classes).click()
    rescue
      break
    end
  end
end

def average(className)
  total = 0
  elements = BR.elements(:class => className)
  number = elements.length
  elements.each do |e|
    total += e.text.gsub("$", '').to_i
  end
  return total / number
end

def scrape
  keep_clicking(CLASSES)
  p average(PRICE_CLASS)
end
