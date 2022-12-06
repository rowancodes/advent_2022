input = File.read("input.txt")
input = input.split("\n")
key = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()-=_+[]{}\\|;':\",.<>/?àáâãäåæ"
total = 0

pairs = input.map {|line|
    two_of_them = line.split(",")
    two_of_them
}

string_pairs = []
pairs.each { |pair|
    i = pair.first.split("-")
    string_one = key[(i.first.to_i-1)..(i.last.to_i-1)]
    i = pair.last.split("-")
    string_two = key[(i.first.to_i-1)..(i.last.to_i-1)]
    string_pairs.push([string_one, string_two])
}

# # part 1
# string_pairs.each { |pair|
# if pair.first.include?(pair.last) || pair.last.include?(pair.first)
#     total += 1
# end
# }

# part 2
string_pairs.each { |pair|
    if (pair.first.split("") & pair.last.split("")) == []
        total += 1
    end
}

p input.length - total