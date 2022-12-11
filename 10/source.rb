$duration = {
    "noop": 1,
    "addx": 2,
}
$clock = 0
$reg_x = 1

$timeline = []
$crt = []

def parser
    $input = File.read("input.txt")
    $input = $input.split("\n")
end

def draw_crt_pixel
    sprite_areas = [$reg_x - 1, $reg_x, $reg_x + 1]
    p sprite_areas
    col = ($clock-1) % 40
    p col
    if sprite_areas.include?(col)
        $crt.push("#")
    else
        $crt.push(".")
    end
end

def display_crt
    p $crt[0..39].join
    p $crt[40..79].join
    p $crt[80..119].join
    p $crt[120..159].join
    p $crt[160..199].join
    p $crt[200..239].join
end

def run_instruction(line)
    split = line.split(" ")
    instruction = split.first
    param = split.last

    $duration[instruction.to_sym].times do
        $clock += 1
        draw_crt_pixel
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

    # part 01
    # sum = 0
    # sum += $timeline[20] * 20
    # sum += $timeline[60] * 60
    # sum += $timeline[100] * 100
    # sum += $timeline[140] * 140
    # sum += $timeline[180] * 180
    # sum += $timeline[220] * 220
    # p sum
    
    display_crt
end

main