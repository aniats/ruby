=begin
Program find polynom derivative 
and counts values. You can change your polynom 
indexes in input_data and your point in
point function.
=end

def main
    puts "Array is: #{input_data}"
    puts "Point is: #{point}"
    puts ""
    solve_with_cycles(input_data, point)
    puts ""
    solve_with_iterators(input_data, point)
end

def point
    1
end

def input_data
    [1, 2, 1]
end

def calculate_with_cycle(array, value)
    res = 0;
    tmp = 1;
    for num in array.reverse do
        tmp *= value
        res += num * tmp
    end
    res
end

def calculate_with_iterators(array, value)
    res = 0;
    tmp = 1;
    array.reverse.each { |num| tmp *= value; res += num * tmp }
    res
end

def find_derivative(array) 
    idx = array.size
    array.collect! { |num| num * idx; idx -= 1}
    array
end

def solve_with_cycles(array, value)
    puts "--Solved with cycles--"
    puts "Polynom value for #{value} is: #{calculate_with_cycle(array, value)}"
    puts "Derivative is #{find_derivative(array)}"
    puts "Derivative value for #{value} is: #{calculate_with_cycle(find_derivative(array), value)}"
end

def solve_with_iterators(array, value)
    puts "--Solved with iterators--"
    puts "Polynom value for #{value} is: #{calculate_with_iterators(array, value)}"
    puts "Derivative is #{find_derivative(array)}"
    puts "Derivative value for #{value} is: #{calculate_with_iterators(find_derivative(array), value)}"
end

if __FILE__ == $0
    main
end