print 'Enter your name: '
name = gets.chomp

name.capitalize!

print "#{name}, enter your height: "
height = gets.chomp.to_i

ideal_weight = height - 110

if ideal_weight.negative?
  printf "#{name}, you have optimal weight!"
else
  printf "#{name}, your ideal weight is #{ideal_weight} kg."
end
