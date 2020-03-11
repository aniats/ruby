#Loop while
while weight < 100 && num_pallets <= 5
    pallet = next_pallet()
    weight += pallet.weight
    num_pallets += 1
end

#Another one
while line = gets
    puts line.downcase
end


#false & nil - are false values