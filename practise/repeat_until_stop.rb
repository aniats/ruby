#Practise

def get_string
  print "Enter a string > "
  string = gets
  if string != nil
    string = string.chomp().lstrip.rstrip
  else 
    string = 'stop, please'
  end
  return string
end

string = get_string
while string != 'stop, please' do
  puts "#{string}"
  string = string
end
puts "Thanks"