#Blocks and iterators
{puts "Hello"}
do 
    club.enroll(person)
    person.socialize
end

#
greet {puts "Hi"}
verbose_great ("Dave") {puts "Hi"}

#Call blocks
def call_block
    puts "Start of the method"
    yield
    puts "End of the method"
end
call_block {puts "In the block"}

call_block do
    puts 42
end

#Start of the method
#In the block
#End of the method

#Start of the method
#42
#End of the method