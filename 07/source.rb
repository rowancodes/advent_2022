$input = ""
$big_dirs = []

class Node
    attr_accessor :next, :prev, :name, :size, :is_file
    def initialize(_name, _size)
        @next = []
        @prev = nil
        @name = _name
        @size = _size
        @is_file = false
    end
    
    def set_prev(node)
        @prev = node
    end

    def add_next(node)
        @next.push(node)
    end
    
    def children_names
        @next.map(&:name)
    end
end

def create_node(name, size, _prev: nil, _next:nil)
    Node.new(name, size)
end

def find_child(parent, node_name)
    return nil if parent.next == []
    list = parent.next
    child = list.detect { |node|
        node.name == node_name
    }
    return child
end

def parser
    $input = File.read("input.txt")
    $input = $input.split("\n")
end

def show_tree(root, level)
    puts "#{"\t"*level}#{root.name} -- #{root.size} -- #{root.is_file}"
    level += 1
    root.next.each { |child|
        show_tree(child, level)
    }
end

def solve_puzzle_01(node)
    if node.is_file == false
        $big_dirs.push([node.name, node.size])
        node.next.each { |child|
            solve_puzzle_01(child)
        }
    else end
end

def calc_folder_sizes(node)
    if node.size == nil
        size_map = node.next.map { |child|
            calc_folder_sizes(child)
        }
        size_map.flatten!
        size = size_map.map(&:to_i).sum
        node.size = size
    elsif node.size != nil
        return node.size
    end
    return size
end

def create_tree
    root = nil
    current = nil
    $input.each { |line| 
        if line == "$ cd /" then root = create_node("root", nil); current = root; next
        elsif line == "$ ls" then 
            next
        elsif line[0..3] == "dir " then
            node = create_node(line[4..-1], nil)
            node.set_prev(current) 
            current.add_next(node)
        elsif line[0..6] == "$ cd .." then
            current = current.prev
        elsif line[0..4] == "$ cd " then
            splitted = line.split(" ")
            current = find_child(current, splitted.last)
        else 
            splitted = line.split(" ")
            node = create_node(splitted.last, splitted.first)
            node.set_prev(current)
            node.is_file = true
            current.add_next(node)
        end
    }
    return root
end

def main
    parser
    root = create_tree
    calc_folder_sizes(root)
    show_tree(root, 0)
    solve_puzzle_01(root)

    # # part 01
    # answer_list = $big_dirs.select { |dir| dir[1] < 100000 }
    # p answer_list
    # answer = answer_list.map { |dir| dir[1] }.sum
    # p answer

    # part 02
    answer_list = $big_dirs.map {|x| x[1]}.sort
    max = root.size
    unused = 70000000 - max
    goal = 30000000
    answer = answer_list.detect { |num|
        (unused + num) >= goal
    }
    p answer
end

main