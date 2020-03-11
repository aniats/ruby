#Work application

def get_num(str, idx)
    puts "Your #{str} is > #{ARGV[idx]} "
    num = ARGV[idx].chomp().strip.to_i
    return num
end

def check_argv
    if ARGV.length < 2
        puts "Too few arguments"
        exit(1)
    elsif ARGV.length > 2
        puts "Too many arguments"
        exit(1)
    end
end

def main 
    check_argv    
    money = get_num("investment", 0)
    days = get_num("days", 1)

    days.times do 
        money = get_res(money)
    end
    puts "You have #{money} left." 
end

if __FILE__ == $0
    main
end
