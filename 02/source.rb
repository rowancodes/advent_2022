input = File.read("input.txt")
input = input.split("\n")
final_score = 0
asdf = []
input.map { |line| 
    asdf.push(line)
}

win_moves = {
    A: "Y",
    B: "Z",
    C: "X",
}

lose_moves = {
    A: "Z",
    B: "X",
    C: "Y",
}

score = {
    X: 1,
    Y: 2,
    Z: 3,
}

me_win = {
    A: 2,
    B: 3,
    C: 1,
}

me_lose = {
    A: 3,
    B: 1,
    C: 2,
}

asdf.each { |move|
    # opp = move.split("").first
    # me  = move.split("").last
    # if win_moves[opp.to_sym] == me 
    #     final_score += 6
    #     final_score += score[me.to_sym]
    # elsif lose_moves[opp.to_sym] == me
    #     final_score += score[me.to_sym]
    # else
    #     final_score += 3
    #     final_score += score[me.to_sym]
    # end

    opp = move.split("").first
    solution = move.split("").last
    if solution == "Z"
        final_score += me_win[opp.to_sym]
        final_score += 6
    elsif solution == "X"
        final_score += me_lose[opp.to_sym]
    else
        draw_amount = me_win.find_index {|k,_| k == opp.to_sym} + 1
        final_score += draw_amount
        final_score += 3
        p draw_amount
    end
}

p final_score