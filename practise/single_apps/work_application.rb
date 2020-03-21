#Work application
#ruby .\work_application.rb --name=Petr --surname=Petrovich --experience=7 --age=57 --mail=petr@gmail.com

def data(info)
    for arg in ARGV
        data = arg
        if data =~ /--name=/
            tmp = data[7, data.length]
            if tmp.length > 0
                info[:name] = tmp
            else
                puts "Empty string in --name"
                break
            end
        end
        if data =~ /--surname=/
            tmp = data[10, data.length]
            if tmp.length > 0
                info[:surname] = tmp
            else 
                puts "Empty string in --surname"
                break
            end
        end
        if data =~ /--age=/
            tmp = data[6, data.length]
            if tmp.length > 0
                res = tmp.to_i
                if res > 15 && res < 100
                    info[:age] = tmp.to_i
                else
                    puts "Your age doesn't satisfy requirement: age > 15 & age < 100"
                    break
                end
            else 
                puts "Empty string in --age"
                break
            end
        end
        if data =~ /--experience=/
            tmp = data[13, data.length]
            if tmp.length > 0
                res = tmp.to_i
                info[:experience] = res
            else 
                puts "Empty string in --experience"
                break
            end
        end
        if data =~ /--mail=/
            tmp = data[7, data.length]
            if (tmp.length > 0)
                info[:mail] = tmp
            else 
                puts "Empty string in --mail"
                break
            end
        end
    end
    info
end

def check_argv
    if ARGV.length > 1 && ARGV.length < 5
        puts "Too few arguments"
        exit(1)
    elsif ARGV.length == 1
        puts "You're applying for a job. I'm waiting for your records."
        puts "work_aplication --name=NAME --surname=SURNAME --mail=MAIL --age=AGE --experience=EXPERIENCE"
    elsif ARGV.length > 5
        puts "Too many arguments"
        exit(1)
    end
end

def entrepreneur(info)
    if info[:name] == "Petr" && info[:surname] == "Petrovich"
        return "Entrepreneur "
    end
    return ""
end

def engineer(info)
    if info[:mail].include? "code"
        return "Engineer "
    end
    return ""
end

def intern(info)
    if info[:experience] < 2
        return "Intern "
    end
    return ""
end

def old(info)
    if info[:age] > 45 && info[:age] < 60
        return "Old "
    end
    return ""
end

def profi(info)
    if info[:experience] > 15
        return "Profi "
    end
    return ""
end

def famous(info)
    if info[:experience] > 5
        return "Famous "
    end
    return ""
end

def main 
    check_argv    
    info = Hash.new(nil)
    info = data(info)
    profession = ""
    profession.concat(entrepreneur(info))
    profession.concat(engineer(info))
    profession.concat(intern(info))
    profession.concat(old(info))
    profession.concat(profi(info))
    profession.concat(famous(info))
    puts profession
end

if __FILE__ == $0
    main
end 