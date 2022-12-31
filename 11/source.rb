$monkeys = []

def mult(old, operation_num)
    return (old * operation_num)
end

def plus(old, operation_num)
    return (old + operation_num)
end

class Monkey
    attr_accessor :items, :test, :operation, :inspect_count
    def initialize(_items, _operation, _test, if_true, if_false)
        @items = _items
        @operation = _operation
        @test = _test
        @if_true = if_true
        @if_false = if_false
        @inspect_count = 0
        $monkeys.push(self)
    end

    def choose_target_monkey(old)
        if (old % @test == 0)
            return @if_true
        else
            return @if_false
        end
    end

    def choose_target_and_throw(old)
        target = choose_target_monkey(old)
        grab = @items.shift
        $monkeys[target].items.push(grab)
    end

    def raise_inspect_count
        @inspect_count += 1
    end
end

def init
    # input.txt i didn't want to make a parser ;w;
    Monkey.new([91, 58, 52, 69, 95, 54], -> (v) { mult(v, 13) }, 7, 1, 5)
    Monkey.new([80, 80, 97, 84], -> (v) { mult(v, v) }, 3, 3, 5)
    Monkey.new([86, 92, 71], -> (v) { plus(v, 7) }, 2, 0, 4)
    Monkey.new([96, 90, 99, 76, 79, 85, 98, 61], -> (v) { plus(v, 4) }, 11, 7, 6)
    Monkey.new([60, 83, 68, 64, 73], -> (v) { mult(v, 19) }, 17, 1, 0)
    Monkey.new([96, 52, 52, 94, 76, 51, 57], -> (v) { plus(v, 3) }, 5, 7, 3)
    Monkey.new([75], -> (v) { plus(v, 5) }, 13, 4, 2)
    Monkey.new([83, 75], -> (v) { plus(v, 1) }, 19, 2, 6)
end

def main
    # all monkeys (round):
        # for each item a monkey is holding (turn):
            # monkey inspects item in order
            # operation happens (worry level changes)
            # worry level divided 3 and floored
    init

    20.times do |round_count|
        $monkeys.each {|x| p "items: #{x.items}"}
        p "round #{round_count+1} : #{$monkeys.map(&:inspect_count)}"
        $monkeys.each_with_index { |monkey, i|
            until monkey.items.empty?
                # p "monkey ##{i} items: #{monkey.items}"
                item = monkey.items.first
                monkey.raise_inspect_count
                item = monkey.operation.(item)
                item = (item/3).floor
                monkey.choose_target_and_throw(item)
            end
        }
    end

    p $monkeys.map(&:inspect_count)
    top_two = $monkeys.map(&:inspect_count).sort.last(2)
    p top_two
    p top_two.first * top_two.last
end

main