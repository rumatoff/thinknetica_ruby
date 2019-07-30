print 'Введите первую сторону: '
a = gets.chomp.to_f

print 'Введите вторую сторону: '
b = gets.chomp.to_f

print 'Введите третью сторону: '
c = gets.chomp.to_f

abort 'Таких треугольников не бывает !!!!' if a <= 0 || b <= 0 || c <= 0

equilateral = a == b && b == c

isosceles = (a == b || a == c || b == c) && !equilateral

sides = [a, b, c].sort!

a, b, c = sides

if a**2 + b**2 == c**2
  puts 'Треугольник прямоугольный'
else
  puts 'Треугольник не прямоугольный'
end

puts 'Внимание он равнобедренный!' if isosceles
