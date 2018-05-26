require 'watir'

BR = Watir::Browser.new :chrome
BR.goto('https://www.bunnings.com.au/search/products?facets=CategoryIdPath%3D2a021706-07d5-4648-bf26-2ea8fea049df%20%3E%2090380562-a3ff-40f3-80a4-be8f7bc99b02%20%3E%20ac3dbda6-52e5-4d8f-af2e-b3ab2c2b8c29%20%3E%20edbb125b-0a2d-42d8-9c0f-30be9133b77c')

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
