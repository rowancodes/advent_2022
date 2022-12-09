$count = 0

def parser
    $input = File.read("input.txt")
    $input = $input.split("\n")
end

def create_forest
    forest = []
    $input.each { |line|
        trees = line.split("")
        forest.push(trees)
    }
    return forest
end

def check_visibility(max_height, i, j)
    r1,r2,c1,c2 = true,true,true,true
    visible = true
    row1 = $forest[i.to_i][0...j.to_i]
    row2 = $forest[i.to_i][j.to_i+1..$row_length]

    col1 = []
    col2 = []
    # col1 = $forest[0...i.to_i][j.to_i]
    (0...i.to_i).each do |x|
        col1.push($forest[x][j.to_i])
    end
    # col2 = $forest[i.to_i+1...$row_count][j.to_i]
    (i.to_i+1...$row_count).each do |x|
        col2.push($forest[x][j.to_i])
    end

    if row1.any? { |tree| tree >= max_height }
        r1 = false
    end
    if row2.any? { |tree| tree >= max_height }
        r2 = false
    end
    if col1.any? { |tree| tree >= max_height }
        c1 = false
    end
    if col2.any? { |tree| tree >= max_height }
        c2 = false
    end
    visible = r1 || r2 || c1 || c2
    return visible
end

def main
    parser
    $forest = create_forest
    $row_count = $forest.count
    $row_length = $forest.first.length

    # check every tree
    $forest.each_with_index { |row, i|
        row.each_with_index { |tree, j|
            # if a tree is on one of the outer edges, add 1 to visible count and continue to next tree
            if (j == 0) || (j == $row_length-1) || (i == 0) || (i == $row_count-1)
                $count += 1
                next
            end
            visible = check_visibility(tree, i, j)
            if visible then $count +=1 end
            p "#{$forest[i][j]} || #{$count} // #{i}/#{j} // #{visible}"
        }
    }
    p $count
end

main