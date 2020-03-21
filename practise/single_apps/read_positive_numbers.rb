#Practise read positive numbers

def get_number
    print "Enter a number > "
    gets.chomp().lstrip.rstrip.to_f
end

def result(ok, not_ok)
    puts "Total amount of succesful lines is #{ok}"
    puts "Total amount of unsuccesful lines is #{not_ok}"
end

puts "This program reads a positive numbers."

number = 0.0
ok_read = 0;
not_ok_read = 0;
number = get_number

while number != 99.999
    number = number.round
    if number < 0 || number == 0
        puts "Your number is probably negative or equals zero"
        not_ok_read += 1
    else
        puts "You've successfully entered #{number}"
        ok_read += 1
    end
    number = get_number
end

result(ok_read, not_ok_read)
