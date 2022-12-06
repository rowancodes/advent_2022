input = File.read("input.txt")
input = input.split("\n")
input = input[10..-1]
stack_01 = %w(F D B Z T J R N)
stack_02 = %w(R S N J H)
stack_03 = %w(C R N J G Z F Q)
stack_04 = %w(F V N G R T Q)
stack_05 = %w(L T Q F)
stack_06 = %w(Q C W Z B R G N)
stack_07 = %w(F C L S N H M)
stack_08 = %w(D N Q M T J)
stack_09 = %w(P G S)

$stacks = [stack_01, stack_02, stack_03, stack_04, stack_05, stack_06, stack_07, stack_08, stack_09]

def move(amount, from, to)
    # amount.times do
    #     grab = $stacks[from-1].pop
    #     $stacks[to-1].push(grab)
    # end

    # part 2
    grab = $stacks[from-1].pop(amount)
    grab.each { |box|
        $stacks[to-1].push(box)
    }
end

delimeters = ["move ", " from ", " to "]
input.each { |line|
    line = line.split(Regexp.union(delimeters))
    line = line[1..-1]
    move(line[0].to_i, line[1].to_i, line[2].to_i)
}

$stacks.each { |stack|
    puts stack.pop
}