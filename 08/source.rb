# This was my first attempt at part 01 of day 08
# it was really bad and over-complicated
# so i decided to redo it in source2.rb
# thank you

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

def main
    def detect_if_tree_visible(max_height, i, j)
        condition1, condition2, condition3, condition4 = true,true,true,true
        line_of_trees = []
        #check up
        (0...i).each { |row|
            line_of_trees.push($forest[row][j])
        }
   
        x1 = line_of_trees.any? { |tree| tree.to_i >= max_height.to_i }
        if x1 then (condition1 = false) end 

        line_of_trees = []
        #check down
        (i...$forest.count-1).each { |row|
            line_of_trees.push($forest[row][j])
        }
        x2 = line_of_trees.any? { |tree| tree.to_i >= max_height.to_i }
        if x2 then (condition2 = false) end 

        line_of_trees = []
        #check left
        (0...j).each { |col|
            line_of_trees.push($forest[i][col])
        }
        x3 = line_of_trees.any? { |tree| tree.to_i >= max_height.to_i }

        if x3 then (condition3 = false) end 

        #check right
        line_of_trees = []
        (j...$forest.first.length-1).each { |col|
            line_of_trees.push($forest[i][col])
        }
        x4 = line_of_trees.any? { |tree| tree.to_i >= max_height.to_i }
        if x4 then (condition4 = false) end 

        p "#{max_height} (#{i}/#{j}) ## #{condition1||condition2||condition3||condition4} -- #{condition1} || #{condition2} || #{condition3} || #{condition4}"
        visible = condition1 || condition2 || condition3 || condition4
        return visible
    end
    parser
    $forest = create_forest
    row_count = $forest.count
    $forest.each_with_index { |row, i|
        row_length = row.length
        if (i == 0) || (i == row_count-1) then
            next
        end
        row.each_with_index { |tree, j|
            if (j == 0) || (j == row_length-1)
                next
            end
            if detect_if_tree_visible(tree, i, j) == true then $count += 1 end
        }
    }

    p $forest.count
    p $forest.first.length
    p $count + 99 + 99 + 97 + 97
end

main