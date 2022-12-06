input = File.read("input.txt")
input = input.split("\n")
asdf = []
calories_list = []
input.map { |line| 
    if line != ""
        asdf.push(line)
    else
        calories_list.push(asdf)
        asdf = []
    end
}

most = []
calories_list.each { |elf|
    total_calories = elf.map {|x| x.to_i }.sum
    most.push(total_calories)
}
most.sort!

p most.last(3).sum