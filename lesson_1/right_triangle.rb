print 'Введите первую сторону: '
a = gets.chomp.to_f

print 'Введите вторую сторону: '
b = gets.chomp.to_f

print 'Введите третью сторону: '
c = gets.chomp.to_f

abort 'Таких треугольников не бывает !!!!' if a <= 0 || b <= 0 || c <= 0

equilateral = a == b && b == c ? true : false

isosceles = (a == b || a == c || b == c) && !equilateral ? true : false

if a > b && a > c
  c1 = a
  a = c
elsif b > a && b > c
  c1 = b
  b = c
else
  c1 = c
end

if a**2 + b**2 == c1**2
  puts 'Треугольник прямоугольный'
else
  puts 'Треугольник не прямоугольный'
end

puts 'Внимание он равнобедренный!' if isosceles
