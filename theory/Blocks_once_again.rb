#Blocks once again
def who_says_what
    yield ("Dave", "hello")
    yield ("Andy", "goodbye")
end

who_says_what do |person, phrase|
    puts "#{person} says #{phrase}"
end