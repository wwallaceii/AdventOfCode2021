def read_input(file_name)
    grid = Hash.new()

    File.open(file_name).each do |line|
        coordinates = line.chomp.match /([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)/
        x1 = coordinates[1].to_i
        y1 = coordinates[2].to_i
        x2 = coordinates[3].to_i
        y2 = coordinates[4].to_i
        
        if x1 == x2
            range = y1 < y2 ? (y1..y2) : (y2..y1)

            range.each do |index|
                if !grid[index]
                    grid[index] = Hash.new(0)
                end
                grid[index][x1] += 1
            end
        elsif y1 == y2
            range = x1 < x2 ? ((x1)..(x2)) : ((x2)..(x1))
            range.each do |index|
                if !grid[y1]
                    grid[y1] = Hash.new(0)
                end
                grid[y1][index] += 1
            end
        elsif ((x1 - x2) / (y1 - y2)).abs == 1
            x_incr = x1 < x2 ? 1 : -1
            y_incr = y1 < y2 ? 1 : -1
            x_index = x1
            y_index = y1
            if !grid[y2]
                grid[y2] = Hash.new(0)
            end
            grid[y2][x2] += 1

            while x_index != x2 && y_index != y2 do
                if !grid[y_index]
                    grid[y_index] = Hash.new(0)
                end
                grid[y_index][x_index] += 1
                x_index += x_incr
                y_index += y_incr
            end
        end
    end

    grid
end

def count_overlaps(grid)
    count = 0

    grid.each_value{ |inner_hash| inner_hash.each_value { |value| count += 1 if value > 1} }

    count
end

grid = read_input("input5.txt")

puts count_overlaps(grid)