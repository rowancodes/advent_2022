$head = {x: 0, y: 0}
$tail = {x: 0, y: 0}
$all_tail_positions = []

def create_long_rope(length)
    list = []
    length.times do
        list.push({x: 0, y: 0})
    end
    list
end

def debug(message)
    puts message
end

def cord_diff
    if($head[:x] < $tail[:x]) # left
        if($head[:y] < $tail[:y]) # bottom
            return "BOTTOM-LEFT"
        else # top
            return "TOP-LEFT"
        end
    else # right
        if($head[:y] < $tail[:y]) # bottom
            return "BOTTOM-RIGHT"
        else # top
            return "TOP-RIGHT"
        end
    end
end

$long_rope = create_long_rope(10)

def tail_follow(first, second)
    if (first[:x] == second[:x]) && (first[:y] == second[:y]) # H & T are on top of each other
        # debug("on top")
        # do nothing!
    elsif (first[:x] == second[:x]) && (first[:y] != second[:y]) # Up or down
        if (first[:y] - second[:y]).abs <= 1 # they're touching
            # debug("UP/DOWN, TOUCHING")
            # do nothing!
        else #they're not touching
            # debug("UP/DOWN, not TOUCHING")
            if (first[:y] > second[:y])
                second[:y] += 1
            else
                second[:y] -= 1
            end
        end
    elsif (first[:x] != second[:x]) && (first[:y] == second[:y]) # Left of right
        if (first[:x] - second[:x]).abs <= 1 # they're touching
            # debug("LEFT/RIGHT, TOUCHING")
            # do nothing!
        else #they're not touching
            # debug("LEFT/RIGHT, not TOUCHING")
            if (first[:x] > second[:x])
                second[:x] += 1
            else
                second[:x] -= 1
            end
        end
    else # they're diagonal from each other 0_0
        if  (first[:x] - second[:x]).abs == 1 && (first[:y] - second[:y]).abs == 1
            debug("DIAGONAL, TOUCHING")
            # do nothing
        else
            debug("DIAGONAL, not TOUCHING")
            case cord_diff
            when "TOP-RIGHT" 
                second[:x] += 1; second[:y] += 1;
            when "TOP-LEFT"
                second[:x] -= 1; second[:y] += 1;
            when "BOTTOM-RIGHT"
                second[:x] += 1; second[:y] -= 1;
            when "BOTTOM-LEFT"
                second[:x] -= 1; second[:y] -= 1;
            else
                puts "Couldn't calculate"
                abort
            end
        end
    end
    # p "H: #{first} -- T: #{second}"
end

def move_head(cord, head)
    split = cord.split(" ")
    direction = split.first
    amount = split.last
    amount = amount.to_i

    amount.times do
        case direction
        when "R"
            head[:x] += 1
        when "L"
            head[:x] -= 1
        when "D"
            head[:y] -= 1
        when "U"
            head[:y] += 1
        else
            puts "Unknown Direction encountered: '#{direction}'"
            exit
        end
        $long_rope.each_with_index { |seg,i|
            if $long_rope[i+1] != nil
                # puts "hello: #{i}"
                tail_follow(seg, $long_rope[i+1])
            end
        }
    end
        
end

def parser
    $input = File.read("input.txt")
    $input = $input.split("\n")
end


def main

    parser
    
    $input.each { |cord|
        p $long_rope
        move_head(cord, $long_rope.first)
        $all_tail_positions.push([$long_rope.last[:x], $long_rope.last[:y]])
    }
    p $all_tail_positions.uniq.count
    p $long_rope
end

main