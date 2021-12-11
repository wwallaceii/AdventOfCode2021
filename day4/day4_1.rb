
class Spot
    attr_reader :value
    def initialize(value)
        @value = value
        @marked = false
    end

    def mark
        @marked = true
    end

    def marked?
       @marked
    end

    def to_s
        "#{@value}#{@marked ? "!":""}"
    end

    def to_str
        to_s
    end
end

def create_game_from_file(filename)
    lines = []
    File.open(filename).each do |line|
        lines.push line.chomp.lstrip
    end

    call_numbers = lines[0].split(",").map { |num_string| num_string.to_i}
    line_index = 2
    boards = []
    while line_index < lines.length
        board = Array.new(5)
        board[0] = lines[line_index].split(" ").map { |num_string| Spot.new(num_string.to_i)}
        board[1] = lines[line_index + 1].split(" ").map { |num_string| Spot.new(num_string.to_i)}
        board[2] = lines[line_index + 2].split(" ").map { |num_string| Spot.new(num_string.to_i)}
        board[3] = lines[line_index + 3].split(" ").map { |num_string| Spot.new(num_string.to_i)}
        board[4] = lines[line_index + 4].split(" ").map { |num_string| Spot.new(num_string.to_i)}
        boards.push board
        line_index += 6

    end
    return call_numbers, boards
end

def play_bingo(call_numbers, boards)
    call_numbers.each do |num|
        boards.each do |board|
            board.each do |row|
                index = row.index do |element|
                    element.value == num 
                end
                if !index.nil?
                    row[index].mark
                end
                
            end

            if is_board_bingo(board)
                sum = 0
                board.each do |row| 
                    row.select{|spot| !spot.marked?}.each {|item| sum += item.value}
                end
                puts sum * num
                return num * sum
            end

        end
    end
end

def is_board_bingo(board)
    board.each do |row|
        if row.count{ |spot| spot.marked?} == 5
            return true
        end
    end

    (0..4).each do |index|
        if (board[0][index].marked? &&
            board[1][index].marked? &&
            board[2][index].marked? &&
            board[3][index].marked? &&
            board[4][index].marked?) 

            return true
        end
    end
    
    false
end

def print(board)
    board.each do |row|
        puts row.join(" ")
    end
end

call_numbers, boards = create_game_from_file("input4.txt")
play_bingo(call_numbers, boards)

