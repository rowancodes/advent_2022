def main
    $input = File.read("input.txt")
    $input.split("")

    def find_start
        ($input.length-3).times do |i|
            buffer = $input[i..i+13]
            buffer = buffer.split("")
            p buffer.uniq
            if buffer.uniq.length == 14
                p "GOT IT #{i+14}"
                return i+14
            end
        end
    end
    
find_start
end

main