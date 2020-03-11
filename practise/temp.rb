print "Введите данные: "
data = gets
pp data
pp data.encoding
puts "Read the data: #{data}"

converted_data = data.encode('UTF-8')
pp converted_data
pp converted_data.encoding
puts "Converted data: #{converted_data}"