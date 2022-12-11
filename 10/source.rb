$duration = {
    "noop": 1,
    "addx": 2,
}
$clock = 0
$reg_x = 1

$timeline = []

def parser
    $input = File.read("input.txt")
    $input = $input.split("\n")
end

def signal_strength

end

def run_instruction(line)
    split = line.split(" ")
    instruction = split.first
    param = split.last

    $duration[instruction.to_sym].times do
        $clock += 1
        $timeline.push($reg_x.dup)
    end

    case instruction
    when "noop"
        # do nothing!
    when "addx"
        $reg_x += param.to_i
    else
        puts "Unknown instruction"
        abort
    end
end

def main
    parser
    $timeline.push($reg_x.dup)
    $input.each { |line|
        run_instruction(line)
    }

    sum = 0
    sum += $timeline[20] * 20
    sum += $timeline[60] * 60
    sum += $timeline[100] * 100
    sum += $timeline[140] * 140
    sum += $timeline[180] * 180
    sum += $timeline[220] * 220

    p sum
    p $timeline
end

main