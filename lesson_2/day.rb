print 'Введите число: '
day = gets.chomp.to_i

print 'Введите месяц: '
month = gets.chomp.to_i

print 'Введите год: '
year = gets.chomp.to_i

abort "Порядковый номер даты: #{day}" if month == 1

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if ((year % 4).zero? && !(year % 100).zero?) || (year % 400).zero?
  months[1] = 29
  puts 'У нас високосный год!'
else
  puts 'Год не високосный.'
end

days = months[0..month - 2].reduce(:+) + day

puts "Порядковый номер даты: #{days}"
