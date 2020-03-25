=begin
Program prints nums in array
which idxs are the 
power of 2
=end

def main
    print_array(input_data)
    solve_with_cycles(input_data)
    solve_with_iterators(input_data)
end

def input_data
    [12, -56, 77, 88]
end


=begin
Fixnum#to_s provides the string representation 
of an integer for a given base. 
The method's argument, which defaults to 10, is the base. 
=end
def po2?(n)
    n.to_s(2).count('1') == 1
end

def print_array(array)
    array.each do |number|
        print number, " "
    end
    puts ""
end

def solve_with_cycles(array)
    res = []
    cur_idx = 0

    for number in array
        if po2?(cur_idx)
            res.push(number)
        end
        cur_idx += 1
    end
    print_array(res)
end

def solve_with_iterators(array)
    res = []

    array.each_with_index do |number, index|
        if po2?(index)
            res.push(number)
        end
    end
    print_array(res)
end

if __FILE__ == $0
    main
end