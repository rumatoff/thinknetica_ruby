print 'Enter your name: '
name = gets.chomp.capitalize

print "#{name}, enter your height: "
height = gets.chomp.to_i

ideal_weight = height - 110

if ideal_weight.negative?
  puts "#{name}, you have optimal weight!"
else
  puts "#{name}, your ideal weight is #{ideal_weight} kg."
end
