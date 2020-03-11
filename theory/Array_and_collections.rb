#Collections (arrays)
array = [1, 'cat', 3.14]
puts "First element: #{array[0]}"
array[2] = nil
puts "Array state #{array.inspect}"
puts array
p array

#Another way to creats array
animals = %w{cat dog elephant}
puts a[0]

#Creating array defautly
histogram = Hash.new(0)
p histogram
p histogram['ruby'] # => 0
histogram['ruby'] = histogram['ruby'] + 1 # => 0
p histogram['ruby'] # => 1