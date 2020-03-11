#Loop for
for value in [1, 2, 3] do
    puts value
end

#Same 
3.times do |value|
    puts value
end

#Something
loop do 
    line = gets
    break if line.nil?
    puts line.downcase
end