alphabet = ('a'..'z').to_a
vowels = %w[a e i o u]
vowels_hash = {}

alphabet.each.with_index(1) do |letter, index|
  vowels_hash[letter] = index if vowels.include? letter
end

puts vowels_hash
