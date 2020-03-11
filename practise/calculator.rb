#Practise Calculator

def get_string
    print "Enter a number > "
    gets.chomp().lstrip.rstrip
end

sum = 0.0
puts "This is a calculator. It can count a sum of numbers.
      Calculator adds a number to a sum while it hasn't read 'over'"

string = get_string

while string != "over" do
    number = string.to_f
    sum += number
    puts "Sum is #{sum}"
    puts "Number is #{number}"
    string = get_string
end

puts "Final sum is #{sum}"
