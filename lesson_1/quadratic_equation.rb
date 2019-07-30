print 'Введите коэфицент а: '
a = gets.chomp.to_f

print 'Введите коэфицент b: '
b = gets.chomp.to_f

print 'Введите коэфицент c: '
c = gets.chomp.to_f

d = b**2 - 4 * a * c

if d.negative?
  puts "Дискриминант равен #{d}"
  abort 'Уравнение корней не имеет.'
end

if d.zero?
  x = -b / (2 * a)
  puts "Дискриминант равен #{d}"
  puts "Уравнение имеет один корень x = #{x}"
else
  e = Math.sqrt(d)
  x1 = (-b + e) / (2 * a)
  x2 = (-b - e) / (2 * a)
  puts "Дискриминант равен #{d}"
  puts "x1 = #{x1}"
  puts "x2 = #{x2}"
end