input = File.read("input.txt")
input = input.split("\n")
final = []
priority_score = 0

input.each_slice(3) { |group|
    # first,second = line.partition(/.{#{line.size/2}}/)[1,2]
    # common = (first.split("")) & (second.split(""))
    common = (group[0].split("")) & (group[1].split("")) & (group[2].split(""))
    p "common : #{common}"
    final.push(common)
}

priority_list = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

final.each { |letter|
p letter
    priority_score += (priority_list.index(letter.first)+1)
}
p priority_score