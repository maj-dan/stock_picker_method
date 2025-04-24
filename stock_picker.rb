def stock_picker(stock_price_array)
  operation = stock_price_array.each_with_index.reduce(Hash.new) do |days_hash, (day_stock_price, today)|
    next_day = today + 1
    days_left = stock_price_array.length - next_day
    next_stock_prices = stock_price_array[next_day, days_left]
    break days_hash if next_stock_prices.empty?

    sell_price = next_stock_prices.max
    sell_day = next_stock_prices.index(sell_price) + next_day
    profit = sell_price - day_stock_price

    #permit negative values to profit, in case things goes downhill, minimizing losses
    #It just confirms that the faster you sell it, the better, wich is the next day
    days_hash = {days: [today, sell_day], profit: profit} if days_hash[:profit].is_a?(NilClass)
    days_hash = {days: [today, sell_day], profit: profit} if profit > days_hash[:profit]

    days_hash
  end

  operation[:days]
end

#test
p stock_picker([17,3,6,9,15,8,6,1,10])
p stock_picker([50,45,25,1])