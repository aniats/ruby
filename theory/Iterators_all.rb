#All elements
data = [5, 66, 13, 24, 46]

data.each_with_index do |number, index|
    puts "#{index}: #{number}"
end

#Odd?
res =  data.all? { |number| number.odd? }
puts res

#New array with elements of given squared
res =  data.map { |number| number**2 }
p res

#Sum of array
res =  data.reduce { |memo, number| number + memo }
p res

#Choose all elements more than 40
res =  data.select { |number| number > 40 }
p res

sum_cool = data.map{ |num| num**2}
               .select { |num| num > 500}
               .reduce(&:+)
p sum_cool
