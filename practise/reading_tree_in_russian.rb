#Practise reading "tree" in Russian
if (Gem.win_platform?)
    Encoding.default_external = Encoding.find(Encoding.locale_charmap)
    Encoding.default_internal = __ENCODING__
  
    [STDIN, STDOUT].each do |io|
      io.set_encoding(Encoding.default_external, Encoding.default_internal)
    end
end

def get_string
    print "Enter 'дерево' as much times as you want > "
    data = gets
    if data != nil
        data.chomp().strip
    else
        data = 'конец'
end

puts "This program counts how many times you've entered 'дерево' word"
string = get_string
sum = 0

while string != 'конец'
    if (string == 'дерево')
        sum += 1
    end
    string = get_string
end
puts "You've entered 'дерево' #{sum} times."

