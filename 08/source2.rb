$count = 0
$best_view_count = 0
$best_view_cords = []

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
    (0...i.to_i).each do |x|
        col1.push($forest[x][j.to_i])
    end
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

def count_trees_seen(max_height, i, j)
    row1 = $forest[i.to_i][0...j.to_i]
    row2 = $forest[i.to_i][j.to_i+1..$row_length]

    col1 = []
    col2 = []
    (0...i.to_i).each do |x|
        col1.push($forest[x][j.to_i])
    end
    (i.to_i+1...$row_count).each do |x|
        col2.push($forest[x][j.to_i])
    end

    row1 = row1.reverse
    col1 = col1.reverse

    i1 = row1.find_index { |tree| tree >= max_height } 
    i2 = row2.find_index { |tree| tree >= max_height } 
    i3 = col1.find_index { |tree| tree >= max_height } 
    i4 = col2.find_index { |tree| tree >= max_height } 
    (i1 == nil) ? (i1 = row1.length) : (i1 += 1)
    (i2 == nil) ? (i2 = row2.length) : (i2 += 1)
    (i3 == nil) ? (i3 = col1.length) : (i3 += 1)
    (i4 == nil) ? (i4 = col2.length) : (i4 += 1)
    p "#{max_height} || #{i}/#{j} // #{i1} #{i2} #{i3} #{i4}"
    
    total_seen = i1 * i2 * i3 * i4
    if total_seen >= $best_view_count then
        $best_view_count = total_seen
        $best_view_cords = [i,j]
    end
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
            count_trees_seen(tree, i, j)
            # if visible then $count +=1 end
            # p "#{$forest[i][j]} || #{$count} // #{i}/#{j} // #{visible}"
        }
    }
    count_trees_seen($forest[$best_view_cords[0]][$best_view_cords[1]], $best_view_cords[0], $best_view_cords[1])
    p $best_view_cords
    p $best_view_count
end

main