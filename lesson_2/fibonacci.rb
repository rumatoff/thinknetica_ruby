fibonacci = [0, 1]

while (sum = fibonacci[-2] + fibonacci[-1]) <= 100
  fibonacci << sum
end

puts fibonacci
