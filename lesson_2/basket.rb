basket = {}
i = 1
basket_full_price = 0

loop do
  print "Введите название товара №#{i}: "
  name = gets.chomp

  break if name == 'стоп' || name == 'stop'

  print 'Введите стоимость товара: '
  price = gets.chomp.to_f

  print 'Введите количество товара: '
  quantity = gets.chomp.to_f

  basket[name] = { price: price, quantity: quantity, full_price: price * quantity }
  i += 1
end

basket.each_value do |composition|
  basket_full_price += composition[:full_price]
end

puts "Состав корзины: #{basket}"

puts "Общая стоимость корзины составляет: #{basket_full_price}"
